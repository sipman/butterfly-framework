import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/param.dart';

class GetTaskByIdRequestObject extends Request {
  @Param('id')
  late int id;

  GetTaskByIdRequestObject(HttpRequest request) : super(request);
}