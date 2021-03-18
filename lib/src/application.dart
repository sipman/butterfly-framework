import 'dart:io';

import 'package:butterfly/src/endpoint.dart';

import '../butterfly.dart';

class Application {
  Router router = Router();

  void run() async {
    var _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 1337);

    print('Butterfly is listening on localhost:${_server.port}');

    await for (HttpRequest request in _server) {
      router.handle(Request(request));
      await request.response.close();
    }
  }

  void registerEndpoint(Endpoint endpoint) {
    router.registerEndpoint(endpoint);
  }
}