import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../b_auth/presentation/cubit/number_validation/number_validation_cubit.dart';
import '../../../../theme/colors.dart';
import '../../../../presentation/widgets/custom_bottom_model_sheet.dart';
import '../../../../presentation/widgets/custom_button_widget.dart';
import '../widgets/text_field_widget.dart';

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
  bool isValid = false;
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
        resizeToAvoidBottomInset: false,
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
              padding: const EdgeInsets.only(top: 20.0, right: 10),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: isValid ? AppColors.primaryColor : AppColors.grey),
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
                const SizedBox(height: 40),
                const Center(
                    child: Text('Setup Profile',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      imageFile != null
                          ? CircleAvatar(
                              radius: 77,
                              backgroundColor: AppColors.grey,
                              backgroundImage: FileImage(File(imageFile!.path)),
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
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
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset(
                              'assets/camera.png',
                              height: 20,
                              fit: BoxFit.cover,
                            ),
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
                const SizedBox(height: 32),
                TextFieldWidget(
                  title: 'Your full name',
                  hintText: 'Write your full name here',
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
                Spacer(),
                CustomButtonWidget(
                    borderColor: isValid
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(.5),
                    ontap: () {
                      screenNavigator(context, const SetupProfileScreen());
                    },
                    title: 'CONTINUE',
                    color: isValid
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(.5)),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }
}
