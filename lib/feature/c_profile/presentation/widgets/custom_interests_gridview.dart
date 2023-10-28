import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/helper/context_ext.dart';

import '../../../../theme/colors.dart';

class CustomInterestGridview extends StatefulWidget {
  CustomInterestGridview({super.key});

  @override
  State<CustomInterestGridview> createState() => _CustomInterestGridviewState();
}

class _CustomInterestGridviewState extends State<CustomInterestGridview> {
  final List<String> interests = [
    'Playing',
    'Gardening',
    'Music',
    'Photography',
  ];
  late List<String> modifiedInterests;
  @override
  void initState() {
    super.initState();
    modifiedInterests = List.from(interests);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: modifiedInterests.map((interest) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                interest,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15.sp,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      modifiedInterests.remove(interest);
                    });
                  },
                  child: Icon(Icons.close, color: AppColors.white))
            ],
          ),
        );
      }).toList(),
    );
  }
}
