import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

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
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 18,
                )),
          ),
          leadingWidth: 45,
          titleSpacing: 5,
          title: Text(profilename,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
