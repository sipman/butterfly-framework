import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/PostThePost/PostThePostUseCase.dart';
import '../presenters/PostThePostPresenter.dart';
import '../requests/PostThePostRequest.dart';

class PostThePostEndpoint implements Endpoint<PostThePostRequest> {
  @override
  final String method = 'POST';

  @override
  final String path = '/task';

  @override
  void callback(PostThePostRequest request, Response response) {
    var presenter = PostThePostPresenter(response);
    var useCase = PostThePostUseCase(presenter);

    useCase.execute(request.task);
  }

}