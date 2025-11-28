import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
}
String invertToMonthDayYear(String date) {
  final parts = date.split('/');
  return '${parts[1]}/${parts[0]}/${parts[2]}';
}
