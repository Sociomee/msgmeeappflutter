import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../c_profile/presentation/widgets/text_field_widget.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  late TextEditingController nameController;
  bool isValid = false;

  int remainchar = 64;
  int desc = 150;
  bool isSelected = false;
  @override
  void initState() {
    nameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    // TODO: implement dispose
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
      body: Column(
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
          Container(
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
              controller: nameController,
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
                  'Group Image',
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
          Divider(
            thickness: 3,
            height: 0,
          ),
        ],
      ),
    );
  }
}
