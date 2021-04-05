import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../repositories/task_repository.dart';
import '../../use_cases/list_active_tasks/list_active_tasks_use_case.dart';
import '../presenters/list_active_tasks_presenter.dart';

class ListActiveTasksEndpoint implements Endpoint {
  final TaskRepository _repository;

  ListActiveTasksEndpoint(this._repository);

  @override
  String get path => '/tasks';

  @override
  String get method => 'GET';


  @override
  void callback(Request request, Response response) {
      var presenter = ListActiveTasksPresenter(response);
      var useCase = ListActiveTasksUseCase(presenter, _repository);

      useCase.execute();
  }
}