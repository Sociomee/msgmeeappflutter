import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/data/model/market_model.dart';

import '../../../../../theme/colors.dart';

class MarketPageTab extends StatelessWidget {
  const MarketPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: marketlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            marketlist[index].imageUrl,
                            height: 41,
                            width: 41,
                            fit: BoxFit.cover,
                          )),
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
                            children: [
                              Text(
                                marketlist[index].industry,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
