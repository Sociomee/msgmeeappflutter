import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../common_widgets/custom_button_widget.dart';

class ReportSuccessPage extends StatelessWidget {
  const ReportSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Spacer(),
          Image.asset('assets/report_success.png'),
          Text(
            'Amazing!',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Thank you for your feedback.',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "We appreciate your input and will take it into\nconsideration to improve our services/products.\nIf you have any further comments or suggestions,\nplease don't hesitate to let us know.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomButtonWidget(
                height: 46,
                title: 'Done',
                color: AppColors.primaryColor,
                ontap: () {
                  Navigator.pop(context);
                }),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
