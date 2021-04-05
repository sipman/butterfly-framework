import 'package:butterfly/src/response.dart';

import '../../domaine/task.dart';
import '../../use_cases/create_new_task/create_new_task_listener.dart';
import '../response_objects/error_response.dart';
import '../response_objects/task_response.dart';

class CreateNewTaskPresenter implements CreateNewTaskListener {
  final Response _response;

  const CreateNewTaskPresenter(this._response);

  @override
  void onInvalidData() {
    _response.onUnprocessableEntity(ErrorResponse.fromMessage('Both title and description are required!'));
  }

  @override
  void onSaved(Task savedTask) {
    _response.onCreated(TaskResponse.fromObject(savedTask));
  }

}