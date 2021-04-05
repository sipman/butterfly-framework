import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/Body.dart';

import '../transferObjects/TaskDTO.dart';

class PostThePostRequest extends Request {
  @Body()
  late TaskDTO task;

  PostThePostRequest(HttpRequest request) : super(request);
}