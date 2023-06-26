import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../../../c_social_chat/presentation/pages/msgmee_screen.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/text_field_widget.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController numberController;
  File? imageFile;
  bool isvalid = false;
  bool isTyping = false;
  int remainchar = 64;
  int remainchar1 = 64;
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
    numberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text('Profile Settings',
              style: TextStyle(color: AppColors.black)),
        ),
        backgroundColor: AppColors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Stack(
                        children: [
                          imageFile != null
                              ? CircleAvatar(
                                  radius: 87,
                                  backgroundColor: AppColors.grey,
                                  backgroundImage:
                                      FileImage(File(imageFile!.path)),
                                )
                              : Container(
                                  height: 172,
                                  width: 172,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Image.asset('assets/profile_icon.png'),
                                ),
                          Positioned(
                            top: 140,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                //showing bottom model sheet to upload image
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    builder: (context) {
                                      return BottomModelSheet(
                                        cameraClick: () {
                                          pickCprofilePic();
                                        },
                                        galleryClick: () {
                                          pickGprofilePic();
                                        },
                                      );
                                    });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Image.asset('assets/camera.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text('Nina Elle',
                          style:
                              TextStyle(color: AppColors.black, fontSize: 22)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'This will be your display picture, this picture will be visible\n to your connections or contacts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 42),
                    TextFieldWidget(
                      title: 'What’s your name?',
                      // hintText: 'Write your full name here',
                      hintText: 'Nina Elle',
                      controller: nameController,
                      onChanged: (e) {
                        setState(() {
                          remainchar = 64 - nameController.text.length;
                        });
                      },
                      remainChar: remainchar.toString(),
                    ),
                    TextFieldWidget(
                        remainChar: remainchar1.toString(),
                        title: 'Pick a username*',
                        hintText: '@nin_ja012',
                        controller: userNameController,
                        showchar: false,
                        onChanged: (e) {
                          if (imageFile != null &&
                              nameController.text.isNotEmpty &&
                              userNameController.text.isNotEmpty) {
                            setState(() {
                              isvalid = true;
                              isTyping = true;
                            });
                          } else {
                            setState(() {
                              isvalid = false;
                              isTyping = false;
                            });
                          }
                          setState(() {
                            remainchar1 = 64 - userNameController.text.length;
                          });
                        }),
                    // isTyping ? SuggestionWidget() : Container(),
                    const Text(
                      'Help your friends to find you on SocioMee with a unique Username',
                      style:
                          TextStyle(color: AppColors.iconColor, fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      title: 'Mobile Number',
                      hintText: '(+91)9876543210',
                      controller: numberController,
                      onChanged: (e) {},
                      remainChar: remainchar.toString(),
                      showchar: false,
                    ),
                    const SizedBox(height: 80),
                    CustomButtonWidget(
                        borderColor: isvalid
                            ? AppColors.primaryColor
                            : AppColors.seconderyColor,
                        ontap: () {
                          isvalid
                              ? screenNavigator(context, MsgmeeScreen())
                              : null;
                        },
                        title: 'SAVE CHANGES',
                        color: AppColors.primaryColor),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
