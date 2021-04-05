import '../../domaine/task.dart';

abstract class CreateNewTaskListener {
  void onSaved(Task savedTask);
  void onInvalidData();
}