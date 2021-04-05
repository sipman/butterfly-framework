import 'dart:convert';
import 'dart:io';

import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../butterfly.dart';

class Application {
  Router router = Router();
  Map<String, String> _headers = {};

  void run() async {
    return HttpServer
        .bind(InternetAddress.loopbackIPv4, 1337)
        .then((server) async {
          print('Butterfly is listening on localhost:${server.port}');
          server.listen((HttpRequest incomingRequest) async {
            var request = Request(incomingRequest);
            var response = Response();
            await router.handle(request, response);
            _buildResponse(incomingRequest, response);
            await incomingRequest.response.close();
          });
        });
  }

  void registerEndpoint(Endpoint endpoint) {
    router.registerEndpoint(endpoint);
  }

  void setHeader(String header, String value) {
    _headers[header] = value;
  }

  void _buildResponse(HttpRequest request, Response response) {
    request.response
        ..statusCode = response.responseCode
        ..headers.contentType = response.contentType;

    for (var header in _headers.entries) {
      request.response.headers.add(header.key, header.value);
    }

    if (response.contentType == ContentType.json) {
      request.response.write(jsonEncode(response.body));
    } else {
      request.response.write(response.body);
    }
  }
}