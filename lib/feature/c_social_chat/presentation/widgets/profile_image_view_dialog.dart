import 'package:flutter/material.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import 'profile_image_screen.dart';

class ProfileViewDialog extends StatelessWidget {
  const ProfileViewDialog(
      {super.key, required this.profilename, required this.imageUrl});
  final String profilename;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          InkWell(
              onTap: () {
                screenNavigator(
                    context,
                    ProfileImageViewScreen(
                      profilename: profilename,
                      imageUrl: imageUrl,
                    ));
              },
              child: Image.network(imageUrl,
                  height: 328, width: 328, fit: BoxFit.cover)),
          Positioned(
            top: 0,
            child: Opacity(
              opacity: 0.63,
              child: Container(
                height: 42,
                width: 328,
                padding:
                    EdgeInsets.only(left: 17, top: 8, bottom: 8, right: 17),
                decoration: BoxDecoration(color: AppColors.black),
                child: Text(
                  profilename,
                  style: TextStyle(color: AppColors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 54,
              width: 328,
              color: AppColors.black.withOpacity(0.63),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                height: 54,
                width: 328,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/msg.png', width: 16),
                    Image.asset('assets/w_call.png', width: 16),
                    Image.asset('assets/w_video.png', width: 16),
                    Icon(Icons.error_outlined, color: AppColors.white, size: 18)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
