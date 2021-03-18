import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldUseCase.dart';
import '../presenters/SayHelloWorldPresenter.dart';

class SayHelloWorldEndpoint implements Endpoint {
  @override
  String path = '/sayHello';

  @override
  String method = 'get';

  @override
  Function(Request, Response) callback = (request, response) {
    var presenter = SayHelloWorldPresenter(response);
    var useCase = SayHelloWorldUseCase(presenter);

    var id;
    if (request.params['id'] != null) {
     id = int.parse(request.params['id']!);
    }

    useCase.execute(id);
  };
}