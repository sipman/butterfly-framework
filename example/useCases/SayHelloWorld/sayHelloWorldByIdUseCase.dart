import 'dart:io';

import 'sayHelloWorldByIdListener.dart';

class SayHelloWorldByIdUseCase {
  SayHelloWorldListener _listener;
  SayHelloWorldByIdUseCase(this._listener);

  void execute(int? id) {
    if (id != null) {
      _listener.onSayHelloWorld('Hello user with id: ' + id.toString());
    } else {
      _listener.onSayHelloWorld('Hello guest!');
    }
  }
}