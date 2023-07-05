import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

class ImageEditingPage extends StatefulWidget {
  const ImageEditingPage({super.key, required this.image});
  final File? image;
  @override
  State<ImageEditingPage> createState() => _ImageEditingPageState();
}

class _ImageEditingPageState extends State<ImageEditingPage> {
  final List<File?> imagelist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 40,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios, color: AppColors.black))),
        centerTitle: true,
        title: Image.asset('assets/sun.png'),
        actions: [
          TextButton(
              onPressed: () {},
              child:
                  Text('Next', style: TextStyle(color: AppColors.primaryColor)))
        ],
      ),
      body: Column(
        children: [
          Image.file(widget.image!,
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
        ],
      ),
    );
  }
}
