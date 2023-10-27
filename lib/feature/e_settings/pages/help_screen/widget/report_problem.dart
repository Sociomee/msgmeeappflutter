import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../../theme/colors.dart';
import '../../../../../common_widgets/custom_bottom_model_sheet.dart';
import '../report_success_page.dart';

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
  bool enable = false;

  @override
  void initState() {
    reasonController = TextEditingController();
    reasonController.addListener(() {
      enableButton();
    });
    super.initState();
  }

  enableButton() {
    setState(() {
      enable = reasonController.text.trim().isNotEmpty;
    });
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
    double height = 368;
    double width = context.screenWidth / 2 - 30;
    // 175;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.arrow_back_ios,
                      color: AppColors.black, size: 18))),
          leadingWidth: 40,
          titleSpacing: 6,
          title: Text('Report a Problem',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Please explain what happened',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                    controller: reasonController,
                    maxLines: 7,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(360),
                    ],
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 5, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppColors.primaryColor)),
                      hintText: 'Type your reason (optional)...',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 131, 131, 131),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onChanged: (e) {
                      setState(() {
                        remainchar = 360 - reasonController.text.length;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'Max $remainchar Characters',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Center(
                  child: TextButton(
                child: Text(
                    imageFileList!.isEmpty
                        ? 'Add Screenshot'
                        : 'Add more screenshots',
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 16)),
                onPressed: () {
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
                            pickCameraImage();
                            Navigator.pop(context);
                          },
                          galleryClick: () {
                            pickGalleryImage();
                            Navigator.pop(context);
                          },
                        );
                      });
                },
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10,
                    childAspectRatio: width / height,
                    // 175 / 368,
                    children: List.generate(imageFileList!.length, (index) {
                      return Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: width,
                                    height: height,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.primaryColor)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Center(
                                            child: Image.file(
                                                File(
                                                    imageFileList![index].path),
                                                width: width,
                                                height: height,
                                                fit: BoxFit.cover))),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageFileList!.removeAt(index);
                                  });
                                },
                                child: Container(
                                    height: 25,
                                    width: 25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.white, width: 3),
                                        color: AppColors.mediaiconColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(Icons.remove,
                                        color: AppColors.white, size: 15)),
                              )),
                        ],
                      );
                    })),
              ),
              SizedBox(height: imageFileList!.isEmpty ? 250.h : 70),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Disclaimer: Learn about how your data will be used. Please check our ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.20,
                          ),
                        ),
                        TextSpan(
                          text: 'Data Policy',
                          style: TextStyle(
                            color: Color(0xFF2F80ED),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomButtonWidget(
                      height: 46,
                      title: 'Submit',
                      borderColor: enable
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(.5),
                      color: enable
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(.5),
                      ontap: () {
                        animatedScreenReplaceNavigator(
                            context, ReportSuccessPage());
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
