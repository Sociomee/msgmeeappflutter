import 'package:intl/intl.dart';

String getCurrentTime() {
  var now = DateTime.now();
  var formatter = DateFormat('h:mm a');
  return formatter.format(now);
}
