import 'package:butterfly/src/annotations/transferObject.dart';

import '../../domaine/Task.dart';

@TransferObject()
class TaskDTO extends Task {
  TaskDTO._(String title, String description): super(title, description);

  factory TaskDTO.fromJson(Map<String, dynamic> json) {
    return TaskDTO._(json['title']!, json['description']!);
  }
  factory TaskDTO.fromDomain(Task task) {
    return TaskDTO._(task.title, task.description);
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description
  };
}