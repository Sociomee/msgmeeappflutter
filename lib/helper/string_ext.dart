import 'package:intl/intl.dart';

extension StringExtension on String {
  String tocapitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toProfileUrl() {
    return 'https://sociomee-dev.s3.ap-south-1.amazonaws.com/$this';
  }

  String toDateTime() {
    final DateTime now = DateTime.parse(this);
    ;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDateTime = formatter.format(now);
    return '$formattedDateTime';
  }

  String toTime() {
    DateTime dateTime = DateTime.parse(this);
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    String date = DateFormat('dd MMMM', 'en_US').format(dateTime);
    print("Date: $date");
    return time;
  }

  String removeNonNumeric() {
    return this.replaceAll(RegExp(r'[^\d]+'), '');
  }

  String removeFirstTwoCharsAndNormalize() {
    final numericString = this.replaceAll(RegExp(r'[^0-9]'), '');
    if (numericString.length > 10) {
      return numericString.substring(2);
    } else {
      return numericString;
    }
  }
}
