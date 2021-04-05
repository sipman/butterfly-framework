import 'package:collection/collection.dart';
import '../domaine/task.dart';
import '../use_cases/create_new_task/CreateNewTaskPersistence.dart';
import '../use_cases/get_task_use_case/get_task_by_id_persistence.dart';
import '../use_cases/get_task_use_case/get_task_by_title_persistence.dart';
import '../use_cases/list_active_tasks/list_active_tasks_persistence.dart';

class TaskRepository implements ListActiveTasksPersistence, CreateNewTaskPersistence, GetTaskByIdPersistence, GetTaskByTitlePersistence {
  List<Task> _tasks = [];

  TaskRepository() {
    _tasks.add(Task(1, 'Opgave 1', 'Beskrivelse 1', true));
    _tasks.add(Task(2, 'Opgave 2', 'Beskrivelse 2', true));
    _tasks.add(Task(3, 'Opgave 3', 'Beskrivelse 3', false));
    _tasks.add(Task(4, 'Opgave 4', 'Beskrivelse 4', false));
    _tasks.add(Task(5, 'Opgave 5', 'Beskrivelse 5', false));
  }

  @override
  List<Task> getActive() {
    return _tasks.where((element) => !element.done).toList();
  }

  @override
  Task save(Task task) {
    var nextId = _tasks.length + 1;
    var newTask = Task(nextId, task.title, task.description, task.done);
    _tasks.add(newTask);

    return newTask;
  }

  @override
  Task? getById(int id) {
    return _tasks.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Task? getFirstByTitle(String title) {
    return _tasks.firstWhereOrNull((element) => element.title.toLowerCase() == title.toLowerCase());
  }

}