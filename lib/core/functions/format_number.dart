import 'package:intl/intl.dart';

dynamic formatNumber(value) {
  var number = value == 'null' ? 'null' : double.parse(value);
  String formattedNumber = value == 'null' ? 'null' : NumberFormat('#,##0.00', 'en_US').format(number);
  return formattedNumber;
}