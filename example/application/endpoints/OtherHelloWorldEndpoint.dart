import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/request.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/SayHelloWorldByUserName.dart';
import '../presenters/SayHelloWorldPresenter.dart';

class OtherHelloWorldEndpoint implements Endpoint {
  @override
  String method = 'get';

  @override
  String path = '/sayHello/{{name: String}}';

  @override
  Function(Request, Response) callback = (request, response) {
    var presenter = SayHelloWorldPresenter(response);
    var useCase = SayHelloWorldByUserNameUseCase(presenter);

    var name = request.params['name'];

    useCase.execute(name);
  };


}