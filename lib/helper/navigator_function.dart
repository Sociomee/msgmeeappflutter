import 'package:flutter/material.dart';

screenNavigator(BuildContext context, Widget child) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => child));
}
