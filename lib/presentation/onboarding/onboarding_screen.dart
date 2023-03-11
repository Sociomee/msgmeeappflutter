import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/theme/custom_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'welcome_screen.dart';
import 'widgets/build_page.dart';

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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 520,
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
                  dotColor: Colors.grey,
                  activeDotColor: CustomTheme.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 45),
            isLastPage
                ? InkWell(
                    onTap: () {
                      animatedScreenNavigator(context, WelcomeScreen());
                    },
                    child: Container(
                      height: 49,
                      width: 116,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomTheme.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: CustomTheme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      pagecontroller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Container(
                      height: 49,
                      width: 116,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomTheme.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: TextStyle(
                            color: CustomTheme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
