import 'list_active_tasks_listener.dart';
import 'list_active_tasks_persistence.dart';

class ListActiveTasksUseCase {
  final ListActiveTasksListener _presenter;
  final ListActiveTasksPersistence _persistence;

  const ListActiveTasksUseCase(this._presenter, this._persistence);

  void execute() {
    var tasks = _persistence.getActive();
    _presenter.onResult(tasks);
  }
}