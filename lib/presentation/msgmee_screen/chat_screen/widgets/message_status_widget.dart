import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

class MessageStatus {
  static var waiting = Icon(
    Icons.access_time,
    size: 16,
  );
  static var sent = Container(
    height: 14,
    width: 14,
    decoration: BoxDecoration(
      color: CustomTheme.grey,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 0.5),
          blurRadius: 0.05,
          spreadRadius: 0.05,
        ),
      ],
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: CustomTheme.white, width: 3),
    ),
  );

  static var delivered = Container(
    height: 14,
    width: 14,
    decoration: BoxDecoration(
      color: CustomTheme.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 0.5),
          blurRadius: 0.05,
          spreadRadius: 0.05,
        ),
      ],
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: CustomTheme.primaryColor, width: 3),
    ),
  );
  static var read = Container(
    height: 14,
    width: 14,
    decoration: BoxDecoration(
      color: CustomTheme.primaryColor,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 0.5),
          blurRadius: 0.05,
          spreadRadius: 0.05,
        ),
      ],
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: CustomTheme.white, width: 3),
    ),
  );
}
