import 'package:butterfly/src/annotations/transferObject.dart';

@TransferObject()
class Date {
  const Date(this.year, this.month, this.day);
  final int year;
  final int month;
  final int day;

  factory Date.fromString(String date) {
    var seperated = date.split('-');
    return Date(int.parse(seperated[0]),int.parse(seperated[1]),int.parse(seperated[2]));
  }
}