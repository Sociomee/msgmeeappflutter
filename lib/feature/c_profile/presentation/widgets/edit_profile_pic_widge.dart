import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_profile/presentation/widgets/text_field_widget.dart';

import '../../../../common_widgets/custom_bottom_model_sheet.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';

class EditProfilePicWidget extends StatefulWidget {
  const EditProfilePicWidget({super.key});

  @override
  State<EditProfilePicWidget> createState() => _EditProfilePicWidgetState();
}

class _EditProfilePicWidgetState extends State<EditProfilePicWidget> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
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

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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
              child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          elevation: 0,
          title:
              Text('Your Profile', style: TextStyle(color: AppColors.black))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
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
                        height: 144,
                        width: 144,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset('assets/profile_icon.png'),
                      ),
                Positioned(
                  top: 115,
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
          Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: CustomButtonWidget(
                  title: 'Update Profile',
                  color: AppColors.primaryColor,
                  ontap: () {
                    Navigator.pop(context);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
