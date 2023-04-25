import 'dart:io';

class Response {
  int _responseCode = 200;
  dynamic _body = '';
  ContentType contentType = ContentType.json;

  int get responseCode {
    return _responseCode;
  }

  dynamic get body {
    return _body;
  }
  Response setContentType(ContentType contentType) {
    this.contentType = contentType;
    return this;
  }

  Response onNotFound(dynamic body) {
    return onResponse(404, body);
  }

  Response onCreated(dynamic body) {
    return onResponse(201, body);
  }

  Response onUnprocessableEntity(dynamic body) {
    return onResponse(422, body);
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