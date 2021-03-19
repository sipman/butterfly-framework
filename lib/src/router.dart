import 'dart:collection';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

class Router {
  LinkedHashMap<String, HashMap<String, Endpoint>> endpoints = LinkedHashMap();

  void handle(Request request, Response response) {
    var method = request.method.toLowerCase();
    var path = request.path.toLowerCase();

    var methodGroup = endpoints[method];
    var endpoint = getEndpoint(path, methodGroup);

    if (methodGroup != null) {
      if (endpoint != null) {
        request.setParams(_convertWildcardsToPAramMap(endpoint, path));
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

  Endpoint? getEndpoint(String path, HashMap<String, Endpoint>? methodGroup) {
    var pathSections = path.split('/');
    var endpointKey = methodGroup?.keys
        .firstWhere(
            (e) => pathMatchesEndpoint(e, pathSections),
            orElse: () => 'Not Found'
    );

    return methodGroup?[endpointKey];
  }

  HashMap<String, String> _convertWildcardsToPAramMap(Endpoint endpoint, String path) {
    var params = HashMap<String, String>();
    var pathSections = path.split('/');
    var endpointSections = endpoint.path.split('/');

    for(var i = 0; i < endpointSections.length; i++) {
      if (_sectionIsWildcard(endpointSections[i])) {
        var wildcard = _convertWildcardToList(endpointSections[i]);
        var varName = wildcard[0].trim();
        var value = pathSections[i];
        params[varName] = value;
      }
    }

    return params;
  }

  bool pathMatchesEndpoint(String element, List<String> pathSections) {
      var sections = element.split('/');
      
      if (sections.length != pathSections.length) {
        return false;
      }

      for(var i = 0; i < sections.length; i++) {
        if (_sectionIsWildcard(sections[i])) {
          return _wildcardValueIsCorrectType(sections[i], pathSections[i]);
        } else if (_sectionsNotEqual(sections[i], pathSections[i])) {
          return false;
        }
      }

      return true;
  }

  bool _wildcardValueIsCorrectType(String section, String pathSection) {
    var wildcard = _convertWildcardToList(section);

    if (wildcard.length > 1) {
      return _checkParamType(pathSection, wildcard[1]);
    }

    return true;
  }

  bool _checkParamType(String param, String typeName) {
    var type = typeName.trim();

    switch(type.toLowerCase()) {
      case 'int':
        return (int.tryParse(param) == null) ? false : true;
      case 'double':
        return (double.tryParse(param) == null) ? false : true;
      case 'boolean':
      case 'bool':
        return (param.toLowerCase() == 'true' ||
                param.toLowerCase() == 'false' ||
                param == '1' ||
                param == '0') ? true : false;
      case 'string':
          return true;
      default: return false;
    }
  }
  
  bool _sectionIsWildcard(String section) {
    return section.startsWith('{{') && section.endsWith('}}');
  }
  
  bool _sectionsNotEqual(String section, String pathSection) {
    return !_sectionIsWildcard(section) && section != pathSection;
  }

  List<String> _convertWildcardToList(String wildcard) {
    return wildcard.replaceAll('{', '').replaceAll('}', '').split(':');
  }
}