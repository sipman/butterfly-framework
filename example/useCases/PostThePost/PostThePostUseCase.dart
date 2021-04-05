import '../../domaine/Task.dart';
import 'PostThePostListener.dart';

class PostThePostUseCase {
  final PostThePostListener presenter;

  const PostThePostUseCase(this.presenter);

  void execute(Task task) {
    presenter.onNewTask(task);
  }
}