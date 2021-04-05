import 'dart:convert';

import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../repositories/task_repository.dart';
import '../../use_cases/get_task_use_case/get_task_by_title_use_case.dart';
import '../presenters/get_task_presenter.dart';

class GetTaskByTitleEndpoint implements Endpoint {
  final TaskRepository _repo;

  GetTaskByTitleEndpoint(this._repo);

  @override
  String get path => '/tasks/{{title: string}}';

  @override
  String get method => 'get';

  @override
  void callback(Request request, Response response) {
    var presenter = GetTaskPresenter(response);
    var useCase = GetTaskByTitleUseCase(presenter, _repo);
    var title = request.params['title']!;

    useCase.execute(Uri.decodeComponent(title));
  }

}