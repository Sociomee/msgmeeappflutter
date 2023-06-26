import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class FingerPrintScreen extends StatelessWidget {
  const FingerPrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text('Fingerprint Lock')),
    );
  }
}
