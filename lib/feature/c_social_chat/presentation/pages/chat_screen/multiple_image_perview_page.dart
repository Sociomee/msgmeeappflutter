import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_status_widget.dart';
import 'package:msgmee/theme/colors.dart';

class MultipleImagePreviewPage extends StatelessWidget {
  const MultipleImagePreviewPage(
      {super.key,
      this.images,
      required this.name,
      required this.date,
      required this.time});
  final List<File?>? images;
  final String name;
  final String date;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFFC8E9D5),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 15),
          ),
        ),
        leadingWidth: 40,
        titleSpacing: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '36 Files',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 5,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: images!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.file(images![index]!,
                              height: 234,
                              width: double.infinity,
                              fit: BoxFit.cover),
                          Divider(
                            height: 0,
                            thickness: 10,
                            color: const Color.fromARGB(255, 177, 177, 177),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 13,
                        left: 10,
                        child: Text(
                          time,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 13,
                        right: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Delivered',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 5),
                            MessageStatus.delivered
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
