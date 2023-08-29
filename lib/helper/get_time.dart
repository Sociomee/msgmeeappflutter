import 'package:intl/intl.dart';

String getTime(String data) {
  DateTime dateTime = DateTime.parse(data);

  String time =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  String date = DateFormat('dd MMMM', 'en_US').format(dateTime);
  print("Date: $date");
  return time;
}
