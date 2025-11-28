import 'package:intl/intl.dart';

String getTodayDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}
