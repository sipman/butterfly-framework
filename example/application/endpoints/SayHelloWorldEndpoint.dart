import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldByIdUseCase.dart';
import '../presenters/SayHelloWorldPresenter.dart';

class SayHelloWorldEndpoint implements Endpoint {
  @override
  String path = '/sayHello/{{id: int}}';

  @override
  String method = 'get';

  @override
  Function(Request, Response) callback = (request, response) {
    var presenter = SayHelloWorldPresenter(response);
    var useCase = SayHelloWorldByIdUseCase(presenter);

    var id = int.tryParse(request.params['id']!);

    useCase.execute(id);
  };
}