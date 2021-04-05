import 'package:butterfly/src/response.dart';

import '../butterfly.dart';

abstract class Endpoint<T extends Request> {
  final String path = '';
  final String method = '';

  void callback(T request, Response response);
}