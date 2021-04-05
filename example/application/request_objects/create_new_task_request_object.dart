import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/Body.dart';
import 'package:butterfly/src/annotations/transfer_object.dart';

import '../../use_cases/create_new_task/CreateNewTaskRequest.dart';

class CreateNewTaskRequestObject extends Request {
  @Body()
  late CreateNewTaskJsonRequest data;

  CreateNewTaskRequestObject(HttpRequest request) : super(request);
}

@TransferObject()
class CreateNewTaskJsonRequest implements CreateNewTaskRequest {
  @override
  String? description;

  @override
  String? title;

  CreateNewTaskJsonRequest._(this.title, this.description);

  factory CreateNewTaskJsonRequest.fromJson(Map<String, dynamic> json) {
    return CreateNewTaskJsonRequest._(json['title'], json['description']);
  }
}