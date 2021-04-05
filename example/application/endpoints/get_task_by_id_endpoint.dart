import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../repositories/task_repository.dart';
import '../../use_cases/get_task_use_case/get_task_by_id_use_case.dart';
import '../presenters/get_task_presenter.dart';
import '../request_objects/get_task_by_id_request_object.dart';

class GetTaskByIdEndpoint implements Endpoint<GetTaskByIdRequestObject> {
  final TaskRepository _repo;

  GetTaskByIdEndpoint(this._repo);

  @override
  String get path => '/tasks/{{id: int}}';

  @override
  String get method => 'get';

  @override
  void callback(GetTaskByIdRequestObject request, Response response) {
    var presenter = GetTaskPresenter(response);
    var useCase = GetTaskByIdUseCase(presenter, _repo);

    useCase.execute(request.id);
  }

}