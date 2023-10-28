// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/colors.dart';
import '../cubit/get_user_details/get_userdetails_cubit.dart';

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
            Text('Choose Gender',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                itemCount: genderList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      if (index == 0) {
                        setState(() {
                          genderList[0].isSelected = true;
                          genderList[1].isSelected = false;
                          genderList[2].isSelected = false;
                        });
                        // context
                        //     .read<UpdateProfileCubit>()
                        //     .updateGender(genderList[0].gender);
                        context
                            .read<GetUserdetailsCubit>()
                            .getUserDetailsCubit();
                        Navigator.pop(context);
                      } else if (index == 1) {
                        setState(() {
                          genderList[1].isSelected = true;
                          genderList[0].isSelected = false;
                          genderList[2].isSelected = false;
                        });
                        // context
                        //     .read<UpdateProfileCubit>()
                        //     .updateGender(genderList[1].gender);
                        context
                            .read<GetUserdetailsCubit>()
                            .getUserDetailsCubit();
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          genderList[0].isSelected = false;
                          genderList[1].isSelected = false;
                          genderList[2].isSelected = true;
                        });
                      }
                    },
                    child: Column(
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
                                        color: AppColors.primaryColor),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  activeColor: AppColors.primaryColor,
                                  value: genderList[index].isSelected,
                                  onChanged: (w) async {
                                    if (index == 0) {
                                      setState(() {
                                        genderList[0].isSelected = true;
                                        genderList[1].isSelected = false;
                                        genderList[2].isSelected = false;
                                      });
                                      // context
                                      //     .read<UpdateProfileCubit>()
                                      //     .updateGender(genderList[0].gender);
                                      context
                                          .read<GetUserdetailsCubit>()
                                          .getUserDetailsCubit();
                                    } else if (index == 1) {
                                      setState(() {
                                        genderList[1].isSelected = true;
                                        genderList[0].isSelected = false;
                                        genderList[2].isSelected = false;
                                      });
                                      // context
                                      //     .read<UpdateProfileCubit>()
                                      //     .updateGender(genderList[1].gender);
                                      context
                                          .read<GetUserdetailsCubit>()
                                          .getUserDetailsCubit();
                                    } else {
                                      setState(() {
                                        genderList[0].isSelected = false;
                                        genderList[1].isSelected = false;
                                        genderList[2].isSelected = true;
                                      });
                                    }

                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                        index == genderList.length - 1
                            ? Container()
                            : Divider(color: AppColors.grey, thickness: 1)
                      ],
                    ),
                  );
                }),
            genderList[2].isSelected == true
                ? Column(
                    children: [
                      Divider(color: AppColors.grey),
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
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      if (index == 0) {
                                        setState(() {
                                          specialCase[0].isSelected = true;
                                          specialCase[1].isSelected = false;
                                          specialCase[2].isSelected = false;
                                        });
                                        // context
                                        //     .read<UpdateProfileCubit>()
                                        //     .updateGender(
                                        //         'I am Special ${specialCase[0].gender}');
                                      } else if (index == 1) {
                                        setState(() {
                                          specialCase[1].isSelected = true;
                                          specialCase[0].isSelected = false;
                                          specialCase[2].isSelected = false;
                                        });
                                        // context
                                        //     .read<UpdateProfileCubit>()
                                        //     .updateGender(
                                        //         'I am Special ${specialCase[1].gender}');
                                      } else {
                                        setState(() {
                                          specialCase[0].isSelected = false;
                                          specialCase[1].isSelected = false;
                                          specialCase[2].isSelected = true;
                                        });
                                        // context
                                        //     .read<UpdateProfileCubit>()
                                        //     .updateGender(
                                        //         'I am Special ${specialCase[2].gender}');
                                      }
                                      context
                                          .read<GetUserdetailsCubit>()
                                          .getUserDetailsCubit();
                                      Navigator.pop(context);
                                    },
                                    child: Column(
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
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  activeColor:
                                                      AppColors.primaryColor,
                                                  value: specialCase[index]
                                                      .isSelected,
                                                  onChanged: (w) async {
                                                    if (index == 0) {
                                                      setState(() {
                                                        specialCase[0]
                                                            .isSelected = true;
                                                        specialCase[1]
                                                            .isSelected = false;
                                                        specialCase[2]
                                                            .isSelected = false;
                                                      });
                                                      // context
                                                      //     .read<
                                                      //         UpdateProfileCubit>()
                                                      //     .updateGender(
                                                      //         'I am Special ${specialCase[0].gender}');
                                                    } else if (index == 1) {
                                                      setState(() {
                                                        specialCase[1]
                                                            .isSelected = true;
                                                        specialCase[0]
                                                            .isSelected = false;
                                                        specialCase[2]
                                                            .isSelected = false;
                                                      });
                                                      // context
                                                      //     .read<
                                                      //         UpdateProfileCubit>()
                                                      //     .updateGender(
                                                      //         'I am Special ${specialCase[1].gender}');
                                                    } else {
                                                      setState(() {
                                                        specialCase[0]
                                                            .isSelected = false;
                                                        specialCase[1]
                                                            .isSelected = false;
                                                        specialCase[2]
                                                            .isSelected = true;
                                                      });
                                                      // context
                                                      //     .read<
                                                      //         UpdateProfileCubit>()
                                                      //     .updateGender(
                                                      //         'I am Special ${specialCase[2].gender}');
                                                    }
                                                    context
                                                        .read<
                                                            GetUserdetailsCubit>()
                                                        .getUserDetailsCubit();
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.grey,
                                          height: 0,
                                          thickness: 1,
                                        )
                                      ],
                                    ),
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
