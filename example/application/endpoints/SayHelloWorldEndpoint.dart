import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldUseCase.dart';
import '../presenters/SayHelloWorldPresenter.dart';

class SayHelloWorldEndpoint implements Endpoint {
  @override
  String path = '/sayHello';

  @override
  String method = 'get';

  @override
  Function(Request) callback = (request) {
    var presenter = SayHelloWorldPresenter(request);
    var useCase = SayHelloWorldUseCase(presenter);

    var id;
    if (request.params['id'] != null) {
     id = int.parse(request.params['id']!);
    }

    useCase.execute(id);
  };
}