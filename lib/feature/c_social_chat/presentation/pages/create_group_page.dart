import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../common_widgets/custom_bottom_model_sheet.dart';
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
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> _bottomSheetKey = GlobalKey();

  bool isValid = false;
  File? imageFile;
  int remainchar = 64;
  int desc = 150;
  bool isSelected = false;
  void pickGprofilePic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  void pickCprofilePic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
    }
  }

  void _showBottomSheet() {
    _bottomSheetKey.currentState!.showBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      (context) {
        return CustomBottomModelSheet(
          cameraClick: () {
            pickCprofilePic();
          },
          galleryClick: () {
            pickGprofilePic();
          },
        );
      },
    );
  }

  // void _closeBottomSheet() {
  //   _bottomSheetKey.currentState?.hideCurrentSnackBar();
  //   _bottomSheetKey.currentState?.hideBottomSheet();
  // }

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
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 24.h,
            ),
          ),
        ),
        leadingWidth: 50.w,
        titleSpacing: 0,
        title: Text(
          'Create Group',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          builder: (context) {
                            return CustomBottomModelSheet(
                              cameraClick: () {
                                pickCprofilePic();
                                Navigator.pop(context);
                              },
                              galleryClick: () {
                                pickGprofilePic();
                                Navigator.pop(context);
                              },
                            );
                          });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: imageFile != null
                  ? Container(
                      height: 120.w,
                      width: 120.w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                                blurRadius: 10,
                                color: AppColors.lightgrey.withOpacity(.5))
                          ],
                          border: Border.all(color: AppColors.white, width: 5),
                          borderRadius: BorderRadius.circular(200),
                          color: const Color.fromARGB(255, 197, 197, 197)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(
                              imageFile!.path,
                            ),
                            fit: BoxFit.cover,
                          )),
                    )
                  : Container(
                      height: 120.w,
                      width: 120.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                                blurRadius: 10,
                                color: AppColors.lightgrey.withOpacity(.5))
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
            Divider(thickness: 3, height: 0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mute Notification',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
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
                          Stack(
                            children: [
                              Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.black.withOpacity(.2),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.6),
                                            BlendMode.dstATop),
                                        image: NetworkImage(
                                            dummyGroupParticipantsData[index]
                                                .imageUrl))),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Text(dummyGroupParticipantsData[index].name,
                              style: TextStyle(
                                  fontSize: 15.sp, color: AppColors.grey)),
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
                ontap: () {
                  Navigator.pop(context);
                },
                title: 'CONTINUE',
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
