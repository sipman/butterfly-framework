import '../../domaine/task.dart';

abstract class GetTaskByTitlePersistence {
  Task? getFirstByTitle(String title);
}