import 'package:butterfly/butterfly.dart';

import '../useCases/PostThePost/PostThePostUseCase.dart';
import 'endpoints/OtherHelloWorldEndpoint.dart';
import 'endpoints/PostThePostEndpoint.dart';
import 'endpoints/SayHelloWorldEndpoint.dart';
import 'endpoints/dateEndpoint.dart';
import 'presenters/PostThePostPresenter.dart';

void main() {
  var application = Application();
  
  application.setHeader("Access-Control-Allow-Origin", "*");
  application.setHeader("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
  
  application.registerEndpoint(SayHelloWorldEndpoint());
  application.registerEndpoint(OtherHelloWorldEndpoint());
  application.registerEndpoint(DateEndpoint());
  application.registerEndpoint(PostThePostEndpoint());

  application.run();
}
