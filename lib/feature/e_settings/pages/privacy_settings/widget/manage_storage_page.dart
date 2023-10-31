import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../../theme/colors.dart';
import '../../../../c_social_chat/presentation/pages/chat_screen/widgets/message_status_widget.dart';
import 'forward_msg_page.dart';
import 'media_preview_widget.dart';

class ManageStoragePage extends StatefulWidget {
  const ManageStoragePage({super.key});

  @override
  State<ManageStoragePage> createState() => _ManageStoragePageState();
}

class _ManageStoragePageState extends State<ManageStoragePage> {
  bool searchMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          shadowColor: AppColors.lightgrey1,
          leading: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: AppColors.black, size: 20))),
          leadingWidth: 45,
          titleSpacing: 0,
          title: Text('Manage Storage',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '3.2 ',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 35,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'GB',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 25,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        'Used',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '12 ',
                              style: TextStyle(
                                color: Color(0xFF4E4E4E),
                                fontSize: 35,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'GB',
                              style: TextStyle(
                                color: Color(0xFF4E4E4E),
                                fontSize: 25,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        'Free',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF4E4E4E),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 5,
              width: 368,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 89,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: AppColors.primaryColor),
                  ),
                  Container(
                      width: 216,
                      height: 10,
                      decoration: BoxDecoration(color: AppColors.yellowColor))
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: ShapeDecoration(
                      color: AppColors.primaryColor,
                      shape: OvalBorder(),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('Social Media',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                  Spacer(),
                  Container(
                      width: 8,
                      height: 8,
                      decoration: ShapeDecoration(
                          color: Color(0xFFF8C756), shape: OvalBorder())),
                  SizedBox(width: 5),
                  Text(
                    'App  and Other item',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Divider(color: AppColors.lightgrey1, thickness: 1),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                screenNavigator(context, ForwardMsgPage());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      'Forworded media many times',
                      style: TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text('9.0 MB',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500)),
                    Icon(Icons.arrow_forward_ios,
                        color: AppColors.black, size: 15)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MediaPreviewWidget(
                        size: '2.3 MB',
                        time: '1:30 AM',
                        image:
                            'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                      );
                    }),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text('Larger than 5 MB',
                      style: TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                  Spacer(),
                  Text('1.1 GB',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                  Icon(Icons.arrow_forward_ios,
                      color: AppColors.black, size: 15)
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MediaPreviewWidget(
                        size: '2.3 MB',
                        time: '1:30 AM',
                        image:
                            'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                      );
                    }),
              ),
            ),
            SizedBox(height: 42),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!searchMode)
                    Text(
                      'Chats',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (searchMode)
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search..',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        searchMode = !searchMode;
                      });
                    },
                    child: Icon(Icons.search, color: AppColors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                    width: 44,
                                    height: 44,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg",
                                            width: 44,
                                            height: 44,
                                            fit: BoxFit.cover))),
                                Positioned(
                                    bottom: 1,
                                    right: 2,
                                    child: MessageStatus.read)
                              ],
                            ),
                            SizedBox(width: 10),
                            Text('Abriella Bond',
                                style: TextStyle(
                                    color: Color(0xFF151624),
                                    fontSize: 16,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500)),
                            Spacer(),
                            Text('229.7 MB',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
