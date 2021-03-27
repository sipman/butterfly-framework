import 'dart:io';
import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/param.dart';

class SayHelloWithStringRequest extends Request {
  @Param('name')
  late String mikkel;

  SayHelloWithStringRequest(HttpRequest request) : super(request);
}