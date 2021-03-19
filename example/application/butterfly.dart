import 'package:butterfly/butterfly.dart';

import 'endpoints/OtherHelloWorldEndpoint.dart';
import 'endpoints/SayHelloWorldEndpoint.dart';

void main() {
  var application = Application();

  application.registerEndpoint(OtherHelloWorldEndpoint());
  application.registerEndpoint(SayHelloWorldEndpoint());

  application.run();
}
