import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../../repositories/task_repository.dart';
import '../../use_cases/create_new_task/create_new_task_use_case.dart';
import '../presenters/create_new_task_presenter.dart';
import '../request_objects/create_new_task_request_object.dart';

class CreateNewTaskEndpoint implements Endpoint<CreateNewTaskRequestObject> {
  final TaskRepository _repo;

  CreateNewTaskEndpoint(this._repo);

  @override
  String get path => '/tasks';

  @override
  String get method => 'post';

  @override
  void callback(CreateNewTaskRequestObject request, Response response) {
    var presenter = CreateNewTaskPresenter(response);
    var createNewTaskUseCase = CreateNewTaskUseCase(presenter, _repo);
    
    createNewTaskUseCase.execute(request.data);
  }

}