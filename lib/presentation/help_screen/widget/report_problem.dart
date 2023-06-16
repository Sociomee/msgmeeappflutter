import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
import '../../../theme/colors.dart';
import '../../../feature/c_profile/presentation/widgets/bottom_sheet_widget.dart';
import '../../../feature/c_profile/presentation/widgets/text_field_widget.dart';
import '../../widgets/custom_bottom_model_sheet.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  late TextEditingController reasonController;
  int remainchar = 360;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  @override
  void initState() {
    reasonController = TextEditingController();
    super.initState();
  }

//pick image from camera
  void pickCameraImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFileList?.add(photo);

      setState(() {});
    }
  }

//pick image from gallery
  void pickGalleryImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        imageFileList?.add(images[i]);
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text('Report a problem',
              style: TextStyle(color: AppColors.black))),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please explain what happened and how should we resolve the issue',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            TextFormField(
                controller: reasonController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColors.primaryColor)),
                  hintText: 'Type your reason (optional)...',
                ),
                onChanged: (e) {
                  setState(() {
                    remainchar = 360 - reasonController.text.length;
                  });
                }),
            Padding(
              padding: EdgeInsets.only(left: 220.0, top: 5),
              child: Text(
                'Max $remainchar Characters',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.black, fontSize: 12),
              ),
            ),
            Center(
                child: TextButton(
              child: Text('Add Screenshot',
                  style:
                      TextStyle(color: AppColors.primaryColor, fontSize: 16)),
              onPressed: () {
                //showing bottom model sheet to upload image
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    builder: (context) {
                      return CustomBottomModelSheet(
                        cameraClick: () {
                          pickCameraImage();
                        },
                        galleryClick: () {
                          pickGalleryImage();
                        },
                      );
                    });
              },
            )),
            SizedBox(
              height: 260,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFileList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 260,
                      margin: EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 260,
                            width: 260,
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Image.file(
                              File(imageFileList![index].path),
                              height: 240,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.mediaiconColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.remove,
                                color: AppColors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Spacer(),
            Text('Disclaimer: Learn about how your data will be used. Please ',
                style: TextStyle(color: AppColors.black, fontSize: 12)),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'check our',
                    style: TextStyle(color: AppColors.black, fontSize: 12)),
                TextSpan(
                    text: ' Data Policy',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
              ]),
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
                title: 'Submit', color: AppColors.primaryColor, ontap: () {}),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
