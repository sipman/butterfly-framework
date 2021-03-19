import 'sayHelloWorldByIdListener.dart';

class SayHelloWorldByUserNameUseCase {
  SayHelloWorldListener _listener;
  SayHelloWorldByUserNameUseCase(this._listener);

  void execute(String? name) {
    if (name != null) {
      _listener.onSayHelloWorld('Hello user with user name: ' + name);
    } else {
      _listener.onSayHelloWorld('Hello guest!');
    }
  }
}