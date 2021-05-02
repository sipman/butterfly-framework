import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../butterfly.dart';

class ServerContext {
  final Router router;
  final Map<String, String> headers;
  ServerContext({required this.router, required this.headers});
}

class Application {
  Router router = Router();
  final Map<String, String> _headers = {};
  int _serverThreads = 6;
  bool _started = false;
  void run() async {
    var context = ServerContext(router: router, headers: _headers);

    for (var i = 1; i < _serverThreads; i++) {
      await Isolate.spawn(_startServer, context);
    }

    // Bind one server in current Isolate
    _startServer(context);
    _started = true;
    print('Serving at http://localhost:1337/');
    if (Platform.isLinux) {
      await ProcessSignal.sigterm.watch().first;
    }
  }

  void registerEndpoint(Endpoint endpoint) {
    router.registerEndpoint(endpoint);
  }

  void setHeader(String header, String value) {
    if (_started) {
      throw Exception('Invalid operation: You cannot alter the headers after running the server');
    }
    _headers[header] = value;
  }

  void setThreads(int num) {
    if (_started) {
      throw Exception('Invalid operation: You cannot alter the amount of threads after running the server');
    }
    _serverThreads = num;
  }

  static void _startServer(ServerContext context) async {
    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      1337,
      shared: true, // This is the magic sauce
    );

    await for (final request in server) {
        try {
          _handleRequest(request, context);
        }  catch(e) {
         _handleInternalServerError(request);
        }
      }
    }

  static void _handleRequest(HttpRequest incomingRequest, ServerContext context) async {
    var request = Request(incomingRequest);
    var response = Response();
    await context.router.handle(request, response);
    _buildResponse(incomingRequest, response, context);
    await incomingRequest.response.flush();
    await incomingRequest.response.close();
  }

  static void _handleInternalServerError(HttpRequest incomingRequest) async {
    incomingRequest.response
      ..statusCode=500
      ..writeln('Internal Server Error 500');
    await incomingRequest.response.flush();
    await incomingRequest.response.close();
  }

  static void _buildResponse(HttpRequest request, Response response, ServerContext context) {
    request.response
        ..statusCode = response.responseCode
        ..headers.contentType = response.contentType;

    for (var header in context.headers.entries) {
      request.response.headers.add(header.key, header.value);
    }

    if (response.contentType == ContentType.json) {
      request.response.write(jsonEncode(response.body));
    } else {
      request.response.write(response.body);
    }
  }
}