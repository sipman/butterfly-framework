import 'package:butterfly/src/response.dart';

import '../../domaine/task.dart';
import '../../use_cases/list_active_tasks/list_active_tasks_listener.dart';
import '../response_objects/task_response.dart';

class ListActiveTasksPresenter implements ListActiveTasksListener {
  final Response _response;

  const ListActiveTasksPresenter(this._response);

  @override
  void onResult(List<Task> tasks) {
    _response.onSuccess(TaskResponse.fromList(tasks));
  }

}