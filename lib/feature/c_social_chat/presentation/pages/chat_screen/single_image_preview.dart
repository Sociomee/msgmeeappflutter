import 'dart:io';

import 'package:flutter/material.dart';

class SingleImagePreView extends StatelessWidget {
  const SingleImagePreView({super.key, required this.image});
  final File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.file(image, width: double.infinity, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
