import 'dart:io';

class Request {
  final HttpRequest _request;

  Request(this._request);

  String get path {
    return _request.uri.path;
  }

  String get method {
    return _request.method;
  }

  Map<String, String> get params {
    return _request.uri.queryParameters;
  }
}