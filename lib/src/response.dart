import 'dart:io';

class Response {
  int _responseCode = 200;
  dynamic _body = '';
  ContentType _contentType = ContentType.json;

  int get responseCode {
    return _responseCode;
  }

  dynamic get body {
    return _body;
  }

  ContentType get contentType {
    return _contentType;
  }

  Response setContentType(ContentType contentType) {
    _contentType = contentType;
    return this;
  }

  Response onNotFound(dynamic body) {
    return onResponse(404, body);
  }

  Response onSuccess(dynamic body) {
    return onResponse(200, body);
  }

  Response onMethodNotAllowed(dynamic body) {
    return onResponse(405, body);
  }

  Response onResponse(int statusCode, dynamic body) {
    _responseCode = statusCode;
    _body = body;
    return this;
  }

}