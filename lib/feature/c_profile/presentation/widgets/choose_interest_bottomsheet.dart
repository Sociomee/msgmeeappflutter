import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';

List<String> interestList = [
  'Photography',
  'Books',
  'Reading',
  'Gaming',
  'Song',
  'Movies',
  'Travelling',
  'Writing',
  'Philosophy',
  'Astrology',
  'Animator',
  'Animals',
  'Acting',
  'Sleeping',
  'Dancing',
];

class ChooseInterestBottomSheet extends StatefulWidget {
  const ChooseInterestBottomSheet({super.key});

  @override
  State<ChooseInterestBottomSheet> createState() =>
      _ChooseInterestBottomSheetState();
}

class _ChooseInterestBottomSheetState extends State<ChooseInterestBottomSheet> {
  List<int> selected = [];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 800.h,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: AppColors.lightgrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 20),
            Text('Choose your Interests',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: 10),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Please select ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(
                  text: 'at least 3 interests',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor.withOpacity(.8))),
              TextSpan(
                  text: ' for a ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: AppColors.black)),
            ])),
            Text('better in-app experience', style: TextStyle(fontSize: 14)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SizedBox(
                height: 200.h,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 103 / 36,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(interestList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (selected.contains(index)) {
                          setState(() {
                            selected.remove(index);
                          });
                        } else {
                          setState(() {
                            selected.add(index);
                          });
                        }
                      },
                      child: Container(
                          height: 36,
                          width: 103,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: selected.contains(index)
                                  ? AppColors.primaryColor
                                  : AppColors.lightgrey1,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            interestList[index],
                            style: TextStyle(
                              color: selected.contains(index)
                                  ? AppColors.white
                                  : Color(0xFF4E4E4E),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 35.h),
            CustomButtonWidget(
                title: 'Save',
                borderColor: Colors.transparent,
                color: selected.isNotEmpty
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(.7),
                ontap: () {})
          ],
        ),
      ),
    );
  }
}
