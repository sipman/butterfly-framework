import '../../domaine/task.dart';

abstract class CreateNewTaskPersistence {
  Task save(Task task);
}