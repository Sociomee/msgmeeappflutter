import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/help_screen/widget/report_problem.dart';
import '../../theme/custom_theme.dart';

class Help {
  final String option;
  final VoidCallback onTap;
  Help({
    required this.option,
    required this.onTap,
  });
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Help> questionsList = [
      Help(option: 'I Need Help', onTap: () {}),
      Help(option: 'I Have Privacy Concern', onTap: () {}),
      Help(option: 'I Have Safety Concern', onTap: () {}),
      Help(option: 'I Have A Suggestion', onTap: () {}),
      Help(option: 'Terms of Service', onTap: () {}),
      Help(option: 'Privacy Policy', onTap: () {}),
      Help(option: 'Data Policy', onTap: () {}),
      Help(option: 'Cookies Policy', onTap: () {}),
      Help(option: 'Community Standards', onTap: () {}),
      Help(
          option: 'Report a problem',
          onTap: () {
            screenNavigator(context, ReportProblemScreen());
          }),
      Help(option: 'About MsgMee', onTap: () {}),
    ];
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: CustomTheme.black)),
          title: Text('Help & Support',
              style: TextStyle(color: CustomTheme.black))),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questionsList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == questionsList.length - 1
                          ? Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'About',
                                      style: TextStyle(
                                        color: CustomTheme.black,
                                      )),
                                  TextSpan(
                                      text: ' MsgMee',
                                      style: TextStyle(
                                          color: CustomTheme.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                            )
                          : InkWell(
                              onTap: questionsList[index].onTap,
                              child: Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(questionsList[index].option),
                              ),
                            ),
                      index == questionsList.length - 1
                          ? Container()
                          : Divider(color: CustomTheme.grey)
                    ],
                  );
                })
          ],
        ),
      )),
    );
  }
}
