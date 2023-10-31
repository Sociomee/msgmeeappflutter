import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/data/model/biz_page_model.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../helper/navigator_function.dart';
import 'biz_page_chat_screen.dart';

class BizPageTab extends StatelessWidget {
  const BizPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bizpage.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    screenNavigator(
                        context,
                        BizPageChatScreen(
                          name: bizpage[index].title,
                          imageUrl: bizpage[index].imageUrl,
                          senderId: 'false',
                          hasStory: false,
                          group: true,
                          lastOnline: '',
                        ));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(bizpage[index].imageUrl,
                                height: 41,
                                width: 41,
                                fit: BoxFit.cover, frameBuilder: (context,
                                    child, frame, wasSynchronouslyLoaded) {
                              return child;
                            }, loadingBuilder:
                                    (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                              }
                            })),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bizpage[index].title,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  bizpage[index].industry,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                    height: 12,
                                    child: VerticalDivider(
                                        color: AppColors.grey, thickness: 1)),
                                Text(
                                  bizpage[index].followers,
                                  style: TextStyle(
                                    color: Color(0xFF81C14B),
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
