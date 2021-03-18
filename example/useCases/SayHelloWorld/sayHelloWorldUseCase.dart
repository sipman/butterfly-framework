import 'sayHelloWorldListener.dart';

class SayHelloWorldUseCase {
  SayHelloWorldListener _listener;
  SayHelloWorldUseCase(this._listener);

  void execute(int? id) {
    if (id != null) {
      _listener.onSayHelloWorld('Hello user with id: ' + id.toString());
    } else {
      _listener.onSayHelloWorld('Hello guest!');
    }
  }
}