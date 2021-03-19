import 'dart:io';
import 'dart:collection';

class Request {
  final HttpRequest _request;
  final HashMap<String, String> _params = HashMap();

  Request(this._request);

  String get path {
    return _request.uri.path;
  }

  String get method {
    return _request.method;
  }

  void  setParam(String key, String value){
    _params[key] = value;
  }

  void setParams(HashMap<String, String> params) {
    _params.addAll(params);
  }

  Map<String, String> get queryParams {
    return _request.uri.queryParameters;
  }

  Map<String, String> get params {
    return _params;
  }


}