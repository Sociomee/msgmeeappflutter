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

  String formatToCustomDate() {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      final hour = dateTime.hour;
      final period = hour < 12 ? 'AM' : 'PM';

      final formattedDate =
          '${dateTime.day} ${_monthName(dateTime.month)}\n$hour $period';

      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  String _monthName(int month) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String toLastOnlineTime() {
    try {
      final inputDateTime = DateTime.parse(this);
      final currentTime = DateTime.now();
      final difference = currentTime.difference(inputDateTime);

      if (difference.inDays > 1) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays == 1) {
        return 'yesterday';
      } else if (difference.inHours > 1) {
        return '${difference.inHours} hours ago';
      } else if (difference.inHours == 1) {
        return 'an hour ago';
      } else if (difference.inMinutes > 1) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'just now';
      }
    } catch (_) {
      return 'Invalid date';
    }
  }

  String iso8601To12HourFormat() {
    try {
      final dateTime = DateTime.parse(this);
      final formattedTime =
          "${_formatHour(dateTime)}:${_formatMinute(dateTime)} ${_getAmPm(dateTime)}";
      return formattedTime;
    } catch (e) {
      // Handle parsing error or invalid date string
      return "Invalid Date";
    }
  }

  String _formatHour(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    return hour.toString().padLeft(2, '0');
  }

  String _formatMinute(DateTime dateTime) {
    return dateTime.minute.toString().padLeft(2, '0');
  }

  String _getAmPm(DateTime dateTime) {
    return dateTime.hour >= 12 ? 'PM' : 'AM';
  }

  String? extractOtp() {
    final RegExp otpRegex = RegExp(r'(\d{6})');
    final Match? match = otpRegex.firstMatch(this);
    return match != null ? match.group(0) : '';
  }
}
