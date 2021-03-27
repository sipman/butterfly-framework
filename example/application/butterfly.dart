import 'package:butterfly/butterfly.dart';

import 'endpoints/OtherHelloWorldEndpoint.dart';
import 'endpoints/SayHelloWorldEndpoint.dart';
import 'endpoints/dateEndpoint.dart';

void main() {
  var application = Application();

  application.registerEndpoint(OtherHelloWorldEndpoint());
  application.registerEndpoint(SayHelloWorldEndpoint());
  application.registerEndpoint(DateEndpoint());

  application.run();
}
