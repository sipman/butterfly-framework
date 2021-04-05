import '../../domaine/task.dart';

abstract class GetTaskListener {
  void onNotFound(int id);
  void onFound(Task task);
  void onNotFoundByTitle(String title);
}