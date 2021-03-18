import 'dart:io';

import 'package:butterfly/butterfly.dart';

import '../../useCases/SayHelloWorld/sayHelloWorldListener.dart';

class SayHelloWorldPresenter implements SayHelloWorldListener {
  final Request _request;

  SayHelloWorldPresenter(this._request);

  @override
  void onSayHelloWorld(String greeting) {
    _request.response
      ..headers.contentType = ContentType.html
      ..statusCode = HttpStatus.ok
      ..write('''<html>
          <head>
            <title>Yaaah, it works!</title>
          </head>
          <body>
            <h1>$greeting</h1>
          </body>
        </html>''');
  }

}