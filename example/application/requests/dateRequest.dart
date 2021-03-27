import 'dart:io';

import 'package:butterfly/butterfly.dart';
import 'package:butterfly/src/annotations/param.dart';

import '../transferObjects/date.dart';

class DateRequest extends Request {
  @Param('date')
  late Date theDate;

  DateRequest(HttpRequest request) : super(request);

}