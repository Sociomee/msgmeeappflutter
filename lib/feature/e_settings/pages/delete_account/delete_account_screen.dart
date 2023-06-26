import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';

import '../../../../theme/colors.dart';
import 'widget/delete_bottom_sheet.dart';

class DeleterAccountScreen extends StatelessWidget {
  const DeleterAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
        title: Text(
          'Delate my account',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Image.asset(
                          'assets/error.png',
                          height: 25,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Deleting your account will:',
                          style: TextStyle(
                              color: AppColors.errorRedColor, fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: AppColors.iconColor,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          SizedBox(width: 8),
                          Text('Erase your message history ')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: AppColors.iconColor,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          SizedBox(width: 8),
                          Text('Delete you from all your MsgMee\ngroups')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: AppColors.iconColor,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          SizedBox(width: 8),
                          Text('Delete your all Google Drive backup')
                        ],
                      ),
                    ),
                    Text('Type your reasion',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          border: OutlineInputBorder(),
                          hintText: 'Type your reason (optional)...'),
                    )
                  ]),
            ),
            SizedBox(height: 20),
            Container(
              height: 82,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: AppColors.lightgrey,
              child: Text(
                'To deleted your account, confirm your country code\nand enter your phone number ',
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
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(),
                    hintText: '(+91)  9876543210'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text('Password',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(),
                    hintText: 'Enter password'),
              ),
            ),
            SizedBox(height: 130.h),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomButtonWidget(
                    borderColor: AppColors.errorRedColor,
                    title: 'Delate my account',
                    color: AppColors.errorRedColor,
                    ontap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          builder: (context) {
                            return DeleteBottomSheet();
                          });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
