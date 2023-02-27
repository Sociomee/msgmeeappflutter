import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

class ProfileImageViewScreen extends StatelessWidget {
  const ProfileImageViewScreen(
      {super.key, required this.profilename, required this.imageUrl});
  final String profilename;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomTheme.black,
            )),
        title: Text(
          profilename,
          style: TextStyle(color: CustomTheme.black),
        ),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
