import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class ChangeWallPaperPage extends StatelessWidget {
  const ChangeWallPaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {},
            child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
        elevation: 1,
        titleSpacing: 0,
        title: Text('Wallpaper', style: TextStyle(color: AppColors.black)),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 533,
            margin: EdgeInsets.symmetric(horizontal: 72),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 3,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x16000000),
                  blurRadius: 6,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x02000000),
                  blurRadius: 9,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x00000000),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                        size: 15,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.grey,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?cs=srgb&dl=pexels-masha-raymers-2726111.jpg&fm=jpg'),
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Abriella Bond',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 4),
                          Text('Active Now',
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.grey)),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.videocam_outlined),
                      SizedBox(width: 13),
                      Icon(Icons.phone_outlined, size: 17),
                      SizedBox(width: 13),
                      Icon(Icons.more_vert_outlined, size: 22)
                    ],
                  ),
                ),
                Divider(color: AppColors.grey, thickness: 1),
                Spacer(),
                Divider(color: AppColors.grey, thickness: 1),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: AppColors.lightgrey1,
                            borderRadius: BorderRadius.circular(30)),
                        child: Transform.rotate(
                            angle: -15,
                            child: Icon(Icons.attach_file_outlined,
                                size: 16, color: AppColors.black))),
                    SizedBox(width: 10),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.photo_camera_outlined,
                          size: 16, color: AppColors.iconColor),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.grey.withOpacity(.4)),
                          color: AppColors.lightgrey1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Type your message',
                            style: TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontSize: 8.48,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 50),
                          Icon(Icons.emoji_emotions_outlined, size: 15)
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.mic_none,
                          size: 16, color: AppColors.iconColor),
                    ),
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
          Spacer(),
          Divider(color: AppColors.grey, thickness: 1),
          SizedBox(height: 42),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 138, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.primaryColor)),
              child: Text(
                'Change',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              )),
          Spacer(),
        ],
      ),
    );
  }
}
