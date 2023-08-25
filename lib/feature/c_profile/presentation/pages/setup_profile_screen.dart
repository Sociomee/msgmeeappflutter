import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../b_auth/presentation/cubit/create_user/create_user_cubit.dart';
import '../../../c_social_chat/presentation/pages/msgmee_screen.dart';
import '../../../b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import '../../../../theme/colors.dart';
import '../../../../common_widgets/custom_bottom_model_sheet.dart';
import '../../../../common_widgets/custom_button_widget.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen(
      {super.key, required this.name, required this.phone});
  final String name;
  final String phone;
  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
  late TextEditingController userNameController;
  File? imageFile;
  bool isValid = false;
  bool isTyping = false;
  int remainchar = 38;
  // int remainchar1 = 64;
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

  @override
  void initState() {
    nameController = TextEditingController();
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateUserCubit, CreateUserState>(
      listener: (context, state) {
        if (state.status == CreateUserStatus.loading) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      context.watch<CreateUserCubit>().state.status ==
                              CreateUserStatus.error
                          ? Text(
                              'Invalid Otp',
                              style: TextStyle(color: AppColors.errorRedColor),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.darkbtnColor))
                    ],
                  ),
                );
              });
        } else if (state.status == CreateUserStatus.loaded) {
          // animatedScreenNavigator(context, MsgmeeScreen());
          log(state.status.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6.0),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      context.watch<NumberValidationCubit>().state.isvalid
                          ? AppColors.darkbtnColor
                          : AppColors.white),
                  value: .90,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ),
              ),
              backgroundColor: AppColors.white,
              elevation: 2,
              actions: [
                GestureDetector(
                  onTap: () {
                    if (imageFile!.path.isNotEmpty) {
                      context.read<CreateUserCubit>().createUser(
                          widget.phone, nameController.text, imageFile!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 10),
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        color: imageFile != null
                            ? AppColors.darkbtnColor
                            : AppColors.grey,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: AppColors.white,
            body: SizedBox(
              height: isTyping
                  ? MediaQuery.of(context).size.height + 193
                  : MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Update your Profile\nPicture',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Center(
                      child: Text(
                        'Set your profile picture for an amazing experience.',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 13.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20),
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          imageFile != null
                              ? Container(
                                  height: 172,
                                  width: 172,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(File(imageFile!.path),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  height: 172,
                                  width: 172,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: SvgPicture.asset('assets/profile.svg'),
                                ),
                          Positioned(
                              top: 130,
                              right: 10,
                              child: GestureDetector(
                                  onTap: () {
                                    //showing bottom model sheet to upload image
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
                                  child: Image.asset('assets/camera2.png',
                                      height: 42, fit: BoxFit.cover)))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Spacer(),
                    CustomButtonWidget(
                        height: 46,
                        borderColor: isValid
                            ? AppColors.darkbtnColor
                            : AppColors.lightgrey,
                        fontsize: 18,
                        ontap: () {
                          if (imageFile!.path.isNotEmpty) {
                            context.read<CreateUserCubit>().createUser(
                                widget.phone, nameController.text, imageFile!);
                          }
                        },
                        title: 'Continue',
                        color: imageFile != null
                            ? AppColors.darkbtnColor
                            : AppColors.lightgrey),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        animatedScreenNavigator(context, MsgmeeScreen());
                      },
                      child: Center(
                        child: Text(
                          'SKIP',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 54),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
