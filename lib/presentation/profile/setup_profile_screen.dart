import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../feature/b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import '../../theme/colors.dart';
import '../msgmee_screen/msgmee_screen.dart';
import '../widgets/custom_bottom_model_sheet.dart';
import '../widgets/custom_button_widget.dart';
import 'widget/suggestion_widget.dart';
import 'widget/text_field_widget.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
  late TextEditingController userNameController;
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
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6.0),
            child: LinearProgressIndicator(
              backgroundColor: AppColors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                  context.watch<NumberValidationCubit>().state.isvalid
                      ? AppColors.primaryColor
                      : AppColors.white),
              value: 1.0,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.black)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 10),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                    color: isvalid ? AppColors.primaryColor : AppColors.grey),
              ),
            )
          ],
        ),
        backgroundColor: AppColors.white,
        body: ListView(
          children: [
            SizedBox(
              height: isTyping
                  ? MediaQuery.of(context).size.height + 193
                  : MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                        child: Text('Setup Profile',
                            style: TextStyle(fontSize: 33))),
                    const SizedBox(height: 20),
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
                                      return CustomBottomModelSheet(
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
                      child: const Text(
                        'This will be your display picture, this picture will be visible\n to your connections or contacts.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.grey, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 42),
                    TextFieldWidget(
                      title: 'What’s your name?',
                      hintText: 'Write your full name here',
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
                        hintText: 'Write your user name here',
                        controller: userNameController,
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
                    isTyping ? SuggestionWidget() : Container(),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                          'Help your friends to find you on SocioMee with a\n unique Username',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: AppColors.grey, fontSize: 12)),
                    ),
                    const SizedBox(height: 60),
                    CustomButtonWidget(
                        borderColor: isvalid
                            ? AppColors.primaryColor
                            : AppColors.seconderyColor,
                        ontap: () {
                          isvalid
                              ? animatedScreenNavigator(context, MsgmeeScreen())
                              : null;
                        },
                        title: 'CONTINUE',
                        color: isvalid
                            ? AppColors.primaryColor
                            : AppColors.seconderyColor),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
