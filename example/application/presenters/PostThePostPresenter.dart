import 'dart:convert';
import 'dart:io';

import 'package:butterfly/src/response.dart';

import '../../domaine/Task.dart';
import '../../useCases/PostThePost/PostThePostListener.dart';
import '../transferObjects/TaskDTO.dart';

class PostThePostPresenter implements PostThePostListener {
  final Response _response;

  const PostThePostPresenter(this._response);

  @override
  void onNewTask(Task task) {
    var dto = TaskDTO.fromDomain(task);
    _response.onSuccess(dto.toJson());
  }

}