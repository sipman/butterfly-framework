import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/param.dart';

class SayHelloWithIdRequest extends Request {
  @Param('id')
  late int id;

  SayHelloWithIdRequest(HttpRequest request) : super(request);
}

