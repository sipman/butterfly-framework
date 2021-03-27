import 'dart:io';
import 'dart:collection';

class Request {
  final HttpRequest request;
  final HashMap<String, String> _params = HashMap();

  Request(this.request);

  String get path {
    return request.uri.path;
  }

  String get method {
    return request.method;
  }

  void  setParam(String key, String value){
    _params[key] = value;
  }

  void setParams(HashMap<String, String> params) {
    _params.addAll(params);
  }

  Map<String, String> get queryParams {
    return request.uri.queryParameters;
  }

  Map<String, String> get params {
    return _params;
  }


}