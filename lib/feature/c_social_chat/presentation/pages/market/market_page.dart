import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/data/model/market_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/market/market_chat_page.dart';

import '../../../../../data/model/dummy_chat_model.dart';
import '../../../../../helper/navigator_function.dart';
import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';
import '../../widgets/profile_image_view_dialog.dart';

class MarketPageTab extends StatefulWidget {
  const MarketPageTab({super.key});

  @override
  State<MarketPageTab> createState() => _MarketPageTabState();
}

class _MarketPageTabState extends State<MarketPageTab> {
  bool changeview = false;
  String image = '';
  String title = '';
  String category = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: changeview
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            changeview = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back_ios, size: 20),
                              SizedBox(width: 10),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: Color(0xFF555555),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.lightgrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      image,
                                      width: 133,
                                      height: 133,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFC700),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: Text(
                                      'Selling',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 216,
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  '354 inquiries',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: Color(0xFF828282),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Text(
                                    'view product in SocioMee',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: AppColors.lightgrey1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      '112 active chat heads',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dummyData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onLongPress: () {},
                              onTap: () {
                                animatedScreenNavigator(
                                    context,
                                    MarketChatScreen(
                                      name: dummyData[index].name,
                                      imageUrl: dummyData[index].imageUrl,
                                      isOnline: dummyData[index].isOnline,
                                      hasStory: dummyData[index].hasStory,
                                    ));
                              },
                              child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.white),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ProfileViewDialog(
                                                  profilename:
                                                      dummyData[index].name,
                                                  imageUrl:
                                                      dummyData[index].imageUrl,
                                                ));
                                      },
                                      child: ChatProfileWidget(
                                          imageUrl: dummyData[index].imageUrl,
                                          isOnline: dummyData[index]
                                              .isOnline
                                              .toString(),
                                          hasStory: dummyData[index].hasStory),
                                    ),
                                    SizedBox(width: 13),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(dummyData[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            )),
                                        SizedBox(height: 8),
                                        Text(dummyData[index].message,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors.grey)),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(dummyData[index].time,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors.grey)),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            dummyData[index].unseenMessage != 0
                                                ? Container(
                                                    height: 20,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3,
                                                            horizontal: 6),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: Text(
                                                        dummyData[index]
                                                            .unseenMessage
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  )
                                                : Container(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                                height: 0,
                                thickness: 1,
                                color: Color(0xFFE4E4E4).withOpacity(.5)),
                          ],
                        );
                      })
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: marketlist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      changeview = true;
                      image = marketlist[index].imageUrl;
                      title = marketlist[index].title;
                      category = marketlist[index].industry;
                    });
                  },
                  child: Container(
                    color: (marketlist[index].sold ?? false)
                        ? AppColors.lightgrey1
                        : AppColors.white,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.h,
                            bottom: 10.h,
                            left: 18,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.lightgrey1,
                              border: Border.all(color: AppColors.lightgrey),
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(marketlist[index].imageUrl,
                                height: 41, width: 41, fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              marketlist[index].title,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (marketlist[index].isSelling != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.yellowColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    child: Text(
                                      marketlist[index].isSelling ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                SizedBox(width: 5),
                                Text(marketlist[index].industry,
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                    height: 12,
                                    child: VerticalDivider(
                                        color: AppColors.grey, thickness: 1)),
                                Text(
                                  marketlist[index].price,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        if (marketlist[index].sold ?? false)
                          Container(
                            height: 65,
                            width: 30,
                            color: AppColors.grey,
                            child: Center(
                              child: Transform.rotate(
                                angle: pi / 2,
                                child: Text(
                                  'Sold',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
