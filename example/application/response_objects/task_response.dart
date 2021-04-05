import 'package:butterfly/src/annotations/transfer_object.dart';

import '../../domaine/task.dart';

class TaskResponse {
  static fromObject(Task task) => {
    'id': task.id,
    'title': task.title,
    'description': task.description,
    'done': task.done
  };

  static fromList(List<Task> tasks) => tasks.map((e) => TaskResponse.fromObject(e)).toList();
}