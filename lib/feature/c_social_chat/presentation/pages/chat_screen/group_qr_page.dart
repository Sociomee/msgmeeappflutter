import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

class GroupQrPage extends StatelessWidget {
  const GroupQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 18,
            ),
          ),
        ),
        title: Text(
          'QR Code',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Icon(Icons.share),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 45),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: AppColors.lightgrey)
                ],
                border: Border.all(color: AppColors.white, width: 5),
                borderRadius: BorderRadius.circular(200),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'College Group',
            style: TextStyle(
              color: Color(0xFF4E4E4E),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 263,
            child: Image.network(
                'https://www.qrstuff.com/images/default_qrcode.png'),
          ),
          SizedBox(height: 54),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'This group QR code is private. If it is shared with someone, they can scan it with their camera to join this group.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
