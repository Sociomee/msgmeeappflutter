import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import 'package:msgmee/feature/c_profile/presentation/widgets/text_field_widget.dart';
import 'package:msgmee/helper/local_data.dart';

import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';
import '../../../b_auth/presentation/cubit/update_user/update_user_cubit.dart';

class EditProfilePicWidget extends StatefulWidget {
  const EditProfilePicWidget({super.key});

  @override
  State<EditProfilePicWidget> createState() => _EditProfilePicWidgetState();
}

class _EditProfilePicWidgetState extends State<EditProfilePicWidget> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
  late TextEditingController usernameController;
  File? imageFile;
  int remainchar = 64;
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

  void deletePic() {
    if (imageFile != null) {
      imageFile!.delete().then((_) {
        setState(() {
          imageFile == null;
        });
      });
    }
  }

  @override
  void initState() {
    nameController = TextEditingController(
        text:
            context.read<GetUserdetailsCubit>().state.response.data!.firstName);
    usernameController = TextEditingController(text: '@shreya_singh012');

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<GetUserdetailsCubit>().state;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leadingWidth: 40,
          titleSpacing: 10,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20,
                ),
              )),
          elevation: 0,
          title: Text('Your Profile',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                imageFile != null
                    ? Container(
                        height: 144,
                        width: 144,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )),
                      )
                    : cubit.response.data!.profilePic != null
                        ? Container(
                            height: 144,
                            width: 144,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  cubit.response.data!.profilePic!,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : Container(
                            height: 144,
                            width: 144,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset('assets/profile_icon.png'),
                          ),
                Positioned(
                  top: 113,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      //showing bottom model sheet to upload image
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          builder: (context) {
                            return ProfileBottomModelSheet(
                              title: 'Select Your Profile Image ',
                              subheading:
                                  'Use DP, camera or select file from device Gallery.',
                              cameraClick: () {
                                pickCprofilePic();
                                Navigator.pop(context);
                              },
                              galleryClick: () {
                                pickGprofilePic();
                                Navigator.pop(context);
                              },
                              deletePic: () {
                                deletePic();
                                Navigator.pop(context);
                              },
                              hasProfile: imageFile == null ? false : true,
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.asset('assets/camera.png',
                          height: 20, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "The picture you're about to set as your display picture will\nbe visible to your connections.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFieldWidget(
              title: 'Your full name',
              hintText: 'Write your full name here',
              controller: nameController,
              onChanged: (e) {
                setState(() {
                  remainchar = 64 - nameController.text.length;
                });
              },
              remainChar: remainchar.toString(),
              textWeight: FontWeight.bold,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     'Username',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 14,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 12),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: TextFormField(
          //     onTap: () {},
          //     onChanged: (e) {},
          //     controller: usernameController,
          //     cursorColor: AppColors.primaryColor,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(38),
          //     ],
          //     decoration: InputDecoration(
          //         fillColor: AppColors.lightgrey1,
          //         filled: true,
          //         contentPadding:
          //             EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(width: 1, color: AppColors.lightgrey1)),
          //         border: OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(width: 2, color: AppColors.lightgrey1)),
          //         focusedBorder: const OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(width: 2, color: AppColors.primaryColor)),
          //         hintText: '@shreya_singh012',
          //         hintStyle: const TextStyle(
          //             color: AppColors.hinttextColor, fontSize: 14)),
          //   ),
          // ),
          Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: CustomButtonWidget(
                  title: 'Update Profile',
                  height: 50,
                  color: AppColors.primaryColor,
                  ontap: () async {
                    if (nameController.text.toString() !=
                            cubit.response.data!.firstName &&
                        imageFile != null) {
                      var phone = await Localdata().readData('phone');
                      log('phone----->$phone');
                      context
                          .read<UpdateUserCubit>()
                          .updateUser(nameController.text, imageFile!);
                      context
                          .read<GetUserdetailsCubit>()
                          .getUserDetailsCubit(phone);

                      Navigator.pop(context);
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileBottomModelSheet extends StatelessWidget {
  const ProfileBottomModelSheet({
    super.key,
    required this.cameraClick,
    required this.galleryClick,
    this.title,
    this.subheading,
    required this.deletePic,
    required this.hasProfile,
  });
  final VoidCallback cameraClick;
  final VoidCallback galleryClick;
  final VoidCallback deletePic;
  final String? title;
  final String? subheading;
  final bool hasProfile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightgrey),
          ),
          SizedBox(height: 10),
          Text(
            title ?? 'Select Media From?',
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            subheading ?? 'Use camera or select file from device gallery',
            textScaleFactor: 1.0,
            style: TextStyle(
                fontSize: 12.sp, color: Color.fromARGB(255, 109, 109, 109)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              hasProfile
                  ? InkWell(
                      onTap: deletePic,
                      child: Column(
                        children: [
                          Container(
                              height: 60,
                              width: 60,
                              margin: EdgeInsets.symmetric(horizontal: 21),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.lightgrey.withOpacity(.5),
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/trash.svg',
                                  height: 30, fit: BoxFit.contain)),
                          const SizedBox(height: 8),
                          const Text(
                            'Remove Profile',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: cameraClick,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.symmetric(horizontal: 42),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightgrey.withOpacity(.5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(Icons.camera_alt, size: 30),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Camera',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: galleryClick,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.symmetric(
                          horizontal: hasProfile ? 21 : 42),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightgrey.withOpacity(.5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(Icons.image_outlined, size: 30),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
