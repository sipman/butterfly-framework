import 'dart:collection';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

class Router {
  HashMap<String, HashMap<String, Endpoint>> endpoints = HashMap();

  void handle(Request request, Response response) {
    var method = request.method.toLowerCase();
    var path = request.path.toLowerCase();

    var methodGroup = endpoints[method];
    if (methodGroup != null) {
      // TODO: Clean up the wildcard search
      var pathSections = path.split('/');
      var endpointKey = methodGroup.keys.firstWhere((element) {
        var sections = element.split('/');
        if (sections.length != pathSections.length) {
          return false;
        }
        for(var i = 0; i < sections.length; i++) {
          if (!sections[i].startsWith('{{') && !sections[i].endsWith('}}') && sections[i] != pathSections[i]) {
            return false;
          }else if (sections[i].startsWith('{{') && sections[i].endsWith('}}')) {
            var wildcardBody = sections[i].replaceAll('{', '').replaceAll('}', '').split(':');
            var varName = wildcardBody[0].trim();

            if (wildcardBody.length > 1) {
              var type = wildcardBody[1].trim();
              switch(type.toLowerCase()) {
                case 'int':
                  if(int.tryParse(pathSections[i]) == null) {
                    return false;
                  }
              }
            }


            request.setParam(varName, pathSections[i]);
          }
        }
        return true;
      }, orElse: () => 'Not Found');
      var endpoint = methodGroup[endpointKey];
      if (endpoint != null) {
        endpoint.callback(request, response);
      } else {
        response.onNotFound('404 not found.');
      }
    } else {
      response.onMethodNotAllowed('Unsupported request: ${request.method}.');
    }
  }

  void registerEndpoint(Endpoint endpoint) {
    var method = endpoint.method.toLowerCase();
    var path = endpoint.path.toLowerCase();
    if (!endpoints.containsKey(method)) {
      endpoints[method] = HashMap();
    }

    endpoints[method]![path] = endpoint;
  }
}