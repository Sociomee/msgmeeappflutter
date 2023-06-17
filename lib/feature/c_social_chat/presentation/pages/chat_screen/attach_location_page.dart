import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class AttachLocationPage extends StatelessWidget {
  const AttachLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Send Location',
          style: TextStyle(color: AppColors.black),
        ),
        actions: [
          Icon(
            Icons.search,
            color: AppColors.black,
          )
        ],
      ),
      body: Column(children: []),
    );
  }
}
