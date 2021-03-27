import 'package:butterfly/src/annotations/inputConverter.dart';
import 'package:butterfly/src/annotations/transferObject.dart';

@TransferObject()
class Date {
  const Date(this.year, this.month, this.day);
  final int year;
  final int month;
  final int day;

  @InputConverter.fromString()
  static Date convertStringToDate(String date){
    var seperated = date.split('-');
    return Date(int.parse(seperated[0]),int.parse(seperated[1]),int.parse(seperated[2]));
  }
}