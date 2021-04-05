import '../../domaine/task.dart';

abstract class GetTaskByIdPersistence {
  Task? getById(int id);
}