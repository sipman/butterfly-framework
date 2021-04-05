import '../../domaine/task.dart';

abstract class ListActiveTasksListener {
  void onResult(List<Task> tasks);
}