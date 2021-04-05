import '../../domaine/task.dart';

abstract class ListActiveTasksPersistence {
  List<Task> getActive();
}