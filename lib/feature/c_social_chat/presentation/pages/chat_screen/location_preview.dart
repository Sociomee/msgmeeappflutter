import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/map_widget.dart';
import 'package:msgmee/theme/colors.dart';

class LocationPreviewPage extends StatelessWidget {
  const LocationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.arrow_back_ios, color: AppColors.black),
            )),
        leadingWidth: 40,
        titleSpacing: 10,
        title: Text(
          'Abriella Bond',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [Icon(Icons.more_vert, color: AppColors.black)],
      ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * .79,
              width: double.infinity,
              child: MapViewWidget()),
          Spacer(),
          Container(
            height: 76,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg',
                    height: 52,
                    width: 52,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '15 Minutes Left',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Text(
                  'Stop sharing',
                  style: TextStyle(
                    color: Color(0xFFFF3333),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
