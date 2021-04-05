import 'package:butterfly/butterfly.dart';

import '../repositories/task_repository.dart';
import 'endpoints/create_new_task_endpoint.dart';
import 'endpoints/get_task_by_id_endpoint.dart';
import 'endpoints/get_task_by_title_endpoint.dart';
import 'endpoints/list_active_tasks_endpoint.dart';

void main() {
  var taskRepository = TaskRepository();
  var application = Application();

  application.registerEndpoint(GetTaskByIdEndpoint(taskRepository));
  application.registerEndpoint(GetTaskByTitleEndpoint(taskRepository));
  application.registerEndpoint(ListActiveTasksEndpoint(taskRepository));
  application.registerEndpoint(CreateNewTaskEndpoint(taskRepository));

  application.run();
}