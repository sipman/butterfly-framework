import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldByIdUseCase.dart';
import '../presenters/SayHelloWorldPresenter.dart';
import '../requests/SayHelloWithIdRequest.dart';

class SayHelloWorldEndpoint implements Endpoint<SayHelloWithIdRequest> {
  @override
  String path = '/sayHello/{{id: int}}';

  @override
  String method = 'get';

  @override
  void callback(SayHelloWithIdRequest request, Response response) {
    var presenter = SayHelloWorldPresenter(response);
    var useCase = SayHelloWorldByIdUseCase(presenter);

    useCase.execute(request.id);
  }

}