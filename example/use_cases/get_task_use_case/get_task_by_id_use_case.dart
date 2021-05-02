import 'dart:io';

import 'get_task_listener.dart';
import 'get_task_by_id_persistence.dart';

class GetTaskByIdUseCase {
  final GetTaskListener _presenter;
  final GetTaskByIdPersistence _persistence;

  const GetTaskByIdUseCase(this._presenter, this._persistence);

  void execute(int id) {
    sleep(Duration(seconds: 2));
    var task = _persistence.getById(id);

    if (task == null) {
      _presenter.onNotFound(id);
    } else {
      _presenter.onFound(task);
    }
  }

}