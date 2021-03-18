import "dart:io";

class Response {
  int _responseCode = 200;
  String _body = '';
  ContentType _contentType = ContentType.json;

  int get responseCode {
    return _responseCode;
  }

  String get body {
    return _body;
  }

  ContentType get contentType {
    return _contentType;
  }

  Response setContentType(ContentType contentType) {
    _contentType = contentType;
    return this;
  }

  Response onNotFound(String body) {
    return onResponse(404, body);
  }

  Response onSuccess(String body) {
    return onResponse(200, body);
  }

  Response onMethodNotAllowed(String body) {
    return onResponse(405, body);
  }

  Response onResponse(int statusCode, String body) {
    _responseCode = statusCode;
    _body = body;
    return this;
  }

}