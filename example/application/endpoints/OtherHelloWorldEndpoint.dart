import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/SayHelloWorldByUserName.dart';
import '../presenters/SayHelloWorldPresenter.dart';
import '../requests/SayHelloWithStringRequest.dart';

class OtherHelloWorldEndpoint implements Endpoint<SayHelloWithStringRequest> {
  @override
  String method = 'get';

  @override
  String path = '/sayHello/{{name: String}}';

  @override
  void callback(SayHelloWithStringRequest request, Response response) {
    var presenter = SayHelloWorldPresenter(response);
    var useCase = SayHelloWorldByUserNameUseCase(presenter);

    useCase.execute(request.mikkel);
  }


}