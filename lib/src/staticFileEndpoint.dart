import 'dart:io';

import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

class StaticFileEndpoint extends Endpoint<Request> {
  late String _basePath;
  late String _defaultFile;

  StaticFileEndpoint(String basePath, {String defaultFile = 'index.html'}) {
    _basePath = basePath;
    _defaultFile = defaultFile;
  }

  @override
  String get path => '/static';

  @override
  String get method => 'GET';

  @override
  void callback(Request request, Response response) async {
    var path = _rewritePath(request.path);

    final file = File('$_basePath$path');
    var found = await file.exists();
    if (found) {
      var fullPath = file.path;

      if (!fullPath.startsWith(_basePath)) {
        _send404(response);
      } else {
        var content = await file.readAsString();
        response.onSuccess('foobar');
      }
    } else {
      _send404(response);
    }
  }

  void _send404(Response response) {
    response.onNotFound('Whoops, something went wrong');
  }

  String _rewritePath(String path) {
    var newPath = path.replaceAll(this.path, '/');

    if (newPath == '/' || newPath.endsWith('/')) {
      newPath += _defaultFile;
    }

    return newPath;
  }
}
