import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/welcome_screen.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../helper/navigator_function.dart';
import '../widgets/build_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pagecontroller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0, actions: [
          isLastPage
              ? Container()
              : TextButton(
                  onPressed: () {},
                  child: Text('Skip', style: TextStyle(color: Colors.black)))
        ]),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 390.h,
              child: PageView(
                controller: pagecontroller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2;
                  });
                },
                children: const [
                  BuildPages(
                      imageUrl: 'assets/onboarding1.png',
                      descriptionText:
                          'Communicate with your friends\nin a fast, reliable and secure\nway.'),
                  BuildPages(
                      imageUrl: 'assets/onboarding2.png',
                      descriptionText:
                          'Engage with your friends,\nbuild relationships.'),
                  BuildPages(
                      imageUrl: 'assets/onboarding3.png',
                      descriptionText:
                          'Come to MsgMee, and Become\nPart of a Growing Community.'),
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pagecontroller,
                count: 3,
                onDotClicked: (index) => pagecontroller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  spacing: 5,
                  dotColor: AppColors.primaryColor.withOpacity(.5),
                  activeDotColor: AppColors.primaryDarkColor,
                ),
              ),
            ),
            SizedBox(height: 45),
            GestureDetector(
                onTap: isLastPage
                    ? () {
                        animatedScreenNavigator(context, WelcomeScreen());
                      }
                    : () {
                        pagecontroller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                child: Container(
                  width: 55,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child:
                      Icon(Icons.arrow_forward, color: AppColors.primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
