import 'dart:io';

import 'package:butterfly/butterfly.dart';

import 'endpoints/SayHelloWorldEndpoint.dart';

void main() {
  var application = Application();

  application.registerEndpoint(SayHelloWorldEndpoint());

  application.run();
}
