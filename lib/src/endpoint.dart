import '../butterfly.dart';

abstract class Endpoint {
  String path = '';
  String method = '';
  Function(Request) callback = (request) {};
}