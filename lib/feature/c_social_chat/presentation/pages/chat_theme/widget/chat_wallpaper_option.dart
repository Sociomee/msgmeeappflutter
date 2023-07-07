import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/solid_color_page.dart';

import '../../../../../../helper/navigator_function.dart';
import '../../../../../../theme/colors.dart';

class WallpaperOptionsWidget extends StatelessWidget {
  const WallpaperOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String phoneImg =
        'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  animatedScreenNavigator(context, SolidColorPage());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Solid Colors',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&w=600',
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Wallpapers',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ])
            ],
          ),
          SizedBox(height: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                phoneImg,
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'My Phone',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Text(
                    'Set Default Wallpaper',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
