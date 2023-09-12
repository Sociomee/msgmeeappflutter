import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/feature/e_settings/pages/delete_account/widget/delete_account_dialog.dart';
import 'package:msgmee/helper/context_ext.dart';

import '../../../../theme/colors.dart';

class DeleterAccountScreen extends StatefulWidget {
  const DeleterAccountScreen({super.key});

  @override
  State<DeleterAccountScreen> createState() => _DeleterAccountScreenState();
}

class _DeleterAccountScreenState extends State<DeleterAccountScreen> {
  late TextEditingController numberController;
  late TextEditingController passwordController;
  bool enable = false;
  @override
  void initState() {
    numberController = TextEditingController();
    passwordController = TextEditingController();
    numberController.addListener(() {
      validateInput();
    });
    passwordController.addListener(() {
      validateInput();
    });
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  validateInput() {
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    setState(() {
      enable = phoneRegex.hasMatch(numberController.text) &&
          passwordController.text.isNotEmpty &&
          passwordController.text.length > 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('width----->>${context.screenWidth}');
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.arrow_back_ios,
                      color: AppColors.black, size: 20))),
          leadingWidth: 40,
          titleSpacing: 6,
          title: Text('Delete my account',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/error_icon.svg'),
                    SizedBox(width: 12),
                    Text(
                        'By deleting your account, following\nactions will happen ! ',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 50.w, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(Icons.fiber_manual_record,
                          color: AppColors.iconColor, size: 7),
                    ),
                    SizedBox(width: 8),
                    Text('Message history will be erased.',
                        style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 50.w, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(Icons.fiber_manual_record,
                          color: AppColors.iconColor, size: 7),
                    ),
                    SizedBox(width: 8),
                    Text('Reason For Deletion(Optional)',
                        style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 5, left: 50.w, bottom: 5, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(Icons.fiber_manual_record,
                          color: AppColors.iconColor, size: 7),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: context.screenWidth - 86.w,
                      child: Text(
                          'All your Google Drive backup will be deleted.',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Reason For Deletion(Optional)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 43,
                  child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF999999))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 203, 203, 203))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor)),
                          hintText: 'Type your reason...',
                          hintStyle: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400))),
                ),
              )
            ]),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.w),
              alignment: Alignment.centerLeft,
              color: Color(0xFFF6F6F6),
              child: Text(
                'To deleted your account, confirm your country code and enter your phone number',
                style: TextStyle(color: AppColors.black, fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text('Mobile Number',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: SizedBox(
                height: 43,
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF999999))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 203, 203, 203))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor)),
                    hintText: '(+91)  9876543210',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 191, 191, 191),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Password',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: SizedBox(
                height: 43,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF999999))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 203, 203, 203))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor)),
                    hintText: 'Enter password',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 191, 191, 191),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70.h),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 24),
            //     child: CustomButtonWidget(
            //         borderColor: AppColors.errorRedColor,
            //         title: 'Delate my account',
            //         color: AppColors.errorRedColor,
            //         ontap: () {
            //           showModalBottomSheet(
            //               context: context,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20)),
            //               builder: (context) {
            //                 return DeleteBottomSheet();
            //               });
            //         }),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButtonWidget(
                  height: 52,
                  title: 'Delete my account',
                  color: enable
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.5),
                  borderColor: enable
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.5),
                  ontap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteAccountDialog();
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
