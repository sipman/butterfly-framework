A Minimalist Web Framework Built For Specifically For Supporting Clean Architecture

## Usage

A simple usage example:

```dart
import 'package:butterfly/butterfly.dart';

main() {
  var application = Application();

  application.registerEndpoint(SayHelloWorldEndpoint());

  application.run();
}
```