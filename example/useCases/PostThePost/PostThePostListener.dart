import '../../domaine/Task.dart';

abstract class PostThePostListener {
  void onNewTask(Task task);
}