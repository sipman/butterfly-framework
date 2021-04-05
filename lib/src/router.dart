import 'dart:collection';
import 'dart:mirrors';
import 'package:collection/collection.dart';
import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/transferObject.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import 'annotations/Body.dart';
import 'annotations/param.dart';

class Router {
  LinkedHashMap<String, List<Endpoint>> endpoints = LinkedHashMap();

  Future<void> handle(Request request, Response response) async {
    var method = request.method.toLowerCase();
    var path = request.path.toLowerCase();

    var methodGroup = endpoints[method];
    var endpoint = getEndpoint(path, methodGroup);

    if (methodGroup != null) {
      if (endpoint != null) {
        request = _buildCorrectRequest(request, endpoint);
        var params = _convertWildcardsToParamMap(endpoint, path);
        request.setParams(params);
        await _injectDataOnRequest(params, request);
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
    if (!endpoints.containsKey(method)) {
      endpoints[method] = [];
    }

    endpoints[method]!.add(endpoint);
  }

  Future<void> _injectDataOnRequest(Map<String, String> params, Request request) async {
    var reflection = reflect(request);
    var classMirror = reflectClass(request.runtimeType);

    for (var v in reflection.type.declarations.values) {
      if (v.metadata.isNotEmpty) {
        if (v.metadata.first.reflectee is Param) {
          String identifier = v.metadata.first.reflectee.name;
          var varMirror = classMirror.declarations.entries.firstWhere((element) {
            return element.key == v.simpleName;
          }).value as VariableMirror;
          var value = _checkParamType(params[identifier]!, varMirror.type.reflectedType);
          reflection.setField(v.simpleName, value);
        } else if (v.metadata.first.reflectee is Body) {
          var varMirror = classMirror.declarations.entries.firstWhere((element) {
            return element.key == v.simpleName;
          }).value as VariableMirror;

          var value = _parseJsonToTransferObject(await request.body, varMirror.type.reflectedType);

          reflection.setField(v.simpleName, value);
        }
      }
    }
  }

  Request _buildCorrectRequest(Request request, Endpoint endpoint) {
    var reflection = reflect(endpoint);
    var requestClassMirror = reflection.type.instanceMembers[Symbol('callback')]!.parameters[0].type;
    var newRequest = reflectClass(requestClassMirror.reflectedType);
    var foo = newRequest.newInstance(Symbol(''), [request.request]);

    return foo.reflectee;
  }

  Endpoint? getEndpoint(String path, List<Endpoint>? methodGroup) {
    var pathSections = path.split('/');
   var endpoint = methodGroup?.firstWhereOrNull(
            (e) => pathMatchesEndpoint(e.path, pathSections)
    );

    return endpoint;
  }

  HashMap<String, String> _convertWildcardsToParamMap(Endpoint endpoint, String path) {
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
      return _checkSimpleParamType(pathSection, wildcard[1]) != null;
    }

    return true;
  }

  dynamic _parseJsonToTransferObject(Map<String, dynamic> body, Type reflectedType) {
    var reflection = reflectClass(reflectedType);
    if (reflection.metadata.isNotEmpty && reflection.metadata.first.reflectee is TransferObject) {
      for (var m in reflection.declarations.values) {
        if (m is MethodMirror && m.constructorName == Symbol('fromJson')) {
          return reflection.newInstance(Symbol('fromJson'), [body]).reflectee;
        }
      }
    } else {
      throw Exception('The type ${reflectedType.toString()} does not have a fromJson factory');
    }
  }

  dynamic _checkParamType(String param, Type type) {
    var reflection = reflectClass(type);
    if (reflection.metadata.isNotEmpty) {
      if (reflection.metadata.first.reflectee is TransferObject) {
        for (var m in reflection.declarations.values) {
          if (m is MethodMirror && m.constructorName == Symbol('fromString')) {
            return reflection.newInstance(Symbol('fromString'), [param]).reflectee;
          }
        }
      }
    }

    return _checkSimpleParamType(param, type.toString());
  }

  dynamic _checkSimpleParamType(String param, String typeName) {
    var type = typeName.trim();

    switch(type.toLowerCase()) {
      case 'int':
        return int.tryParse(param);
      case 'double':
        return double.tryParse(param);
      case 'boolean':
      case 'bool':
        return (param.toLowerCase() == 'true' ||
                param.toLowerCase() == 'false' ||
                param == '1' ||
                param == '0') ? true : false;
      case 'string':
          return param;
      default: return null;
    }
  }
  
  bool _sectionIsWildcard(String section) {
    return section.startsWith('{{') && section.endsWith('}}');
  }
  
  bool _sectionsNotEqual(String section, String pathSection) {
    return !_sectionIsWildcard(section) && section.toLowerCase() != pathSection.toLowerCase();
  }

  List<String> _convertWildcardToList(String wildcard) {
    return wildcard.replaceAll('{', '').replaceAll('}', '').split(':');
  }
}