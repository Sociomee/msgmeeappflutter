import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class SingleImagePreView extends StatelessWidget {
  const SingleImagePreView({super.key, required this.image});
  final File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: 18,
              ),
            )),
      ),
      body: Center(
        child: Image.file(image, width: double.infinity, fit: BoxFit.cover),
      ),
    );
  }
}
