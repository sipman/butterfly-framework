import '../../domaine/task.dart';
import 'CreateNewTaskPersistence.dart';
import 'CreateNewTaskRequest.dart';
import 'create_new_task_listener.dart';

class CreateNewTaskUseCase {
  final CreateNewTaskListener _presenter;
  final CreateNewTaskPersistence _persistence;

  const CreateNewTaskUseCase(this._presenter, this._persistence);

  void execute(CreateNewTaskRequest newTask) {
    if (newTask.title != null && newTask.description != null) {
      var savedTask = _persistence.save(Task(null, newTask.title!, newTask.description!, false));
      return _presenter.onSaved(savedTask);
    }else {
      return _presenter.onInvalidData();
    }
  }
}