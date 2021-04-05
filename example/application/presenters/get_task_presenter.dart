import 'package:butterfly/src/response.dart';

import '../../domaine/task.dart';
import '../../use_cases/get_task_use_case/get_task_listener.dart';
import '../response_objects/error_response.dart';
import '../response_objects/task_response.dart';

class GetTaskPresenter implements GetTaskListener {
  final Response _response;

  const GetTaskPresenter(this._response);

  @override
  void onFound(Task task) {
    _response.onSuccess(TaskResponse.fromObject(task));
  }

  @override
  void onNotFound(int id) {
    _response.onNotFound(ErrorResponse.fromMessage("Couldn't find a task with id: $id"));
  }

  @override
  void onNotFoundByTitle(String title) {
    _response.onNotFound(ErrorResponse.fromMessage("Couldn't find a task with title: $title"));
  }

}