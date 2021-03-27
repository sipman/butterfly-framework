import 'dart:io';

import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../butterfly.dart';

class Application {
  Router router = Router();

  void run() async {
    var _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 1337);

    print('Butterfly is listening on localhost:${_server.port}');

    await for (HttpRequest incomingRequest in _server) {
      var request = Request(incomingRequest);
      var response = Response();
      router.handle(request, response);
      _buildResponse(incomingRequest, response);
      await incomingRequest.response.close();
    }
  }

  void registerEndpoint(Endpoint endpoint) {
    router.registerEndpoint(endpoint);
  }

  void _buildResponse(HttpRequest request, Response response) {
    request.response
        ..statusCode = response.responseCode
        ..headers.contentType = response.contentType
        ..write(response.body);
  }
}