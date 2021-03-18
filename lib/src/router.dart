import 'dart:collection';
import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';

class Router {
  HashMap<String, HashMap<String, Endpoint>> endpoints = HashMap();

  void handle(Request request) {
    var method = request.method.toLowerCase();
    var path = request.path.toLowerCase();

    var methodGroup = endpoints[method];
    if (methodGroup != null) {
      var endpoint = methodGroup[path];
      if (endpoint != null) {
        endpoint.callback(request);
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('404 not found.');
      }
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request: ${request.method}.');
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