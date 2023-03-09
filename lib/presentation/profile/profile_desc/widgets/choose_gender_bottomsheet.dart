// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../theme/custom_theme.dart';

class Gender {
  final String gender;
  bool isSelected;
  Gender({
    required this.gender,
    required this.isSelected,
  });
}

List<Gender> genderList = [
  Gender(gender: 'Male', isSelected: false),
  Gender(gender: 'Female', isSelected: false),
  Gender(gender: 'I am Special', isSelected: false),
];

List<Gender> specialCase = [
  Gender(gender: 'He', isSelected: false),
  Gender(gender: 'She', isSelected: false),
  Gender(gender: 'Rather not specify', isSelected: false),
];

class ChooseGenderBottomSheet extends StatefulWidget {
  const ChooseGenderBottomSheet({super.key});

  @override
  State<ChooseGenderBottomSheet> createState() =>
      _ChooseGenderBottomSheetState();
}

class _ChooseGenderBottomSheetState extends State<ChooseGenderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: CustomTheme.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: CustomTheme.lightgrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 20),
            Text('Choose Gender',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                itemCount: genderList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(genderList[index].gender),
                            Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 2.0,
                                      color: CustomTheme.primaryColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                activeColor: CustomTheme.primaryColor,
                                value: genderList[index].isSelected,
                                onChanged: (w) {
                                  setState(() {
                                    genderList[index].isSelected =
                                        !genderList[index].isSelected;
                                  });
                                })
                          ],
                        ),
                      ),
                      index == genderList.length - 1
                          ? Container()
                          : Divider(color: CustomTheme.grey)
                    ],
                  );
                }),
            genderList[2].isSelected == true
                ? Column(
                    children: [
                      Divider(color: CustomTheme.grey),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How should we address you',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: specialCase.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(specialCase[index].gender),
                                            Checkbox(
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => BorderSide(
                                                      width: 2.0,
                                                      color: CustomTheme
                                                          .primaryColor),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                activeColor:
                                                    CustomTheme.primaryColor,
                                                value: specialCase[index]
                                                    .isSelected,
                                                onChanged: (w) {
                                                  setState(() {
                                                    specialCase[index]
                                                            .isSelected =
                                                        !specialCase[index]
                                                            .isSelected;
                                                  });
                                                })
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: CustomTheme.grey,
                                        height: 0,
                                      )
                                    ],
                                  );
                                }),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
