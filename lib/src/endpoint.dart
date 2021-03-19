import 'package:butterfly/src/response.dart';

import '../butterfly.dart';

abstract class Endpoint {
  String path = '';
  String method = '';
  Function(Request, Response) callback = (request, response) {};
}