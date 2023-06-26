import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../data/model/group_participants_model.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../../../c_profile/presentation/widgets/text_field_widget.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  late TextEditingController nameController;
  late TextEditingController summeyConroller;
  bool isValid = false;

  int remainchar = 64;
  int desc = 150;
  bool isSelected = false;
  @override
  void initState() {
    nameController = TextEditingController();
    summeyConroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    summeyConroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Create Group',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Group Image',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Add',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: AppColors.lightgrey)
                      ],
                      border: Border.all(color: AppColors.white, width: 5),
                      borderRadius: BorderRadius.circular(200),
                      color: const Color.fromARGB(255, 197, 197, 197)),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/group_img.svg',
                      height: 58,
                      width: 58,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: TextFieldWidget(
                title: 'Name*',
                hintText: 'Enter your group name',
                controller: nameController,
                textWeight: FontWeight.bold,
                onChanged: (e) {
                  setState(() {
                    remainchar = 64 - nameController.text.length;
                    nameController.text.isNotEmpty
                        ? isValid = true
                        : isValid = false;
                  });
                },
                remainChar: remainchar.toString(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: TextFieldWidget(
                title: 'Summary',
                hintText: 'Describe your Group...',
                controller: summeyConroller,
                textWeight: FontWeight.bold,
                onChanged: (e) {
                  setState(() {
                    desc = 64 - nameController.text.length;
                    nameController.text.isNotEmpty
                        ? isValid = true
                        : isValid = false;
                  });
                },
                remainChar: desc.toString(),
              ),
            ),
            Divider(
              thickness: 3,
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mute Notification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      activeColor: AppColors.primaryColor,
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                            width: 1.0, color: AppColors.primaryColor),
                      ),
                      value: isSelected,
                      onChanged: (w) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      }),
                ],
              ),
            ),
            Divider(thickness: 3, height: 0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20),
              child: Text('1 Member',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.grey,
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
                  ),
                  SizedBox(width: 10),
                  Text('You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Spacer(),
                  Text('Group Admin', style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20),
              child: Text('Add participants',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dummyGroupParticipantsData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.grey,
                              backgroundImage: NetworkImage(
                                  dummyGroupParticipantsData[index].imageUrl)),
                          SizedBox(width: 10),
                          Text(dummyGroupParticipantsData[index].name,
                              style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              activeColor: AppColors.primaryColor,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: AppColors.primaryColor),
                              ),
                              value: dummyGroupParticipantsData[index].selected,
                              onChanged: (w) {
                                setState(() {
                                  dummyGroupParticipantsData[index].selected =
                                      !dummyGroupParticipantsData[index]
                                          .selected;
                                });
                              }),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 50.h),
            Center(
              child: CustomButtonWidget(
                borderColor: AppColors.primaryColor,
                // : AppColors.primaryColor.withOpacity(.5),
                ontap: () {},
                title: 'CONTINUE',
                color:
                    // context.watch<NumberValidationCubit>().state.isvalid
                    AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
