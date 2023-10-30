import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';

class ChooseInterestBottomSheet extends StatefulWidget {
  const ChooseInterestBottomSheet({super.key});

  @override
  State<ChooseInterestBottomSheet> createState() =>
      _ChooseInterestBottomSheetState();
}

class _ChooseInterestBottomSheetState extends State<ChooseInterestBottomSheet> {
  List<String> selectedInterests = [];
  final List<String> interests = [
    'Playing',
    'Gardening',
    'Music',
    'Photography',
    'Reading',
    'Writing',
    'Story'
  ];
  late List<String> modifiedInterests;
  @override
  void initState() {
    super.initState();
    modifiedInterests = List.from(interests);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 80,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: AppColors.lightgrey,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(height: 12.w),
          Text('Choose your Interests',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 14.w),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Please select ',
                style: TextStyle(
                    color: Color(0xB2333333),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'at least 3 interests',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor.withOpacity(.8))),
            TextSpan(
                text: ' for a better',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xB2333333)))
          ])),
          Text('in-app experience',
              style: TextStyle(fontSize: 14, color: Color(0xB2333333))),
          SizedBox(height: 20.w),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children: modifiedInterests.map((interest) {
              return InkWell(
                onTap: () {
                  if (selectedInterests.contains(interest)) {
                    setState(() {
                      selectedInterests.remove(interest);
                    });
                  } else {
                    setState(() {
                      selectedInterests.add(interest);
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: selectedInterests.contains(interest)
                        ? AppColors.primaryColor
                        : AppColors.lightgrey1,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        interest,
                        style: TextStyle(
                          color: selectedInterests.contains(interest)
                              ? AppColors.white
                              : Color(0xFF4E4E4E),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: CustomButtonWidget(
                height: 40.w,
                title: 'Save',
                borderColor: Colors.transparent,
                color: selectedInterests.length < 3
                    ? AppColors.primaryColor.withOpacity(.6)
                    : AppColors.primaryColor,
                ontap: () async {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
