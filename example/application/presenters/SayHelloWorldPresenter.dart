import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldListener.dart';

class SayHelloWorldPresenter implements SayHelloWorldListener {
  final Response _response;

  SayHelloWorldPresenter(this._response);

  @override
  void onSayHelloWorld(String greeting) {
    _response.setContentType(ContentType.html).onSuccess('''<html>
          <head>
            <title>Yaaah, it works!</title>
          </head>
          <body>
            <h1>$greeting</h1>
          </body>
        </html>''');
  }

}