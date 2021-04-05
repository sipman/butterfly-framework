import 'get_task_by_title_persistence.dart';
import 'get_task_listener.dart';

class GetTaskByTitleUseCase {
  final GetTaskListener _presenter;
  final GetTaskByTitlePersistence _persistence;

  const GetTaskByTitleUseCase(this._presenter, this._persistence);

  void execute(String title) {
    var task = _persistence.getFirstByTitle(title);

    if (task == null) {
      _presenter.onNotFoundByTitle(title);
    } else {
      _presenter.onFound(task);
    }
  }
}