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
      var endpoint = methodGroup[path];
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