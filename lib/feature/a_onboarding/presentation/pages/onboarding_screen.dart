// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:msgmee/feature/a_onboarding/presentation/pages/welcome_screen.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../helper/navigator_function.dart';
import '../../../c_social_chat/presentation/pages/msgmee_screen.dart';
import '../widgets/build_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pagecontroller;
  bool isLastPage = false;
  int pageIndex = 0;

  @override
  void initState() {
    pagecontroller = PageController();
    super.initState();
  }

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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            // image: pageIndex == 0
            //     ? AssetImage('assets/onboard_bg1.png')
            //     : pageIndex == 1
            //         ? AssetImage('assets/onboard_bg2.png')
            //         : AssetImage('assets/onboard_bg3.png')
            image: AssetImage('assets/onboarding_bg.png'),
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .85,
                child: PageView(
                  controller: pagecontroller,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == 2;
                      pageIndex = index;
                    });
                  },
                  children: [
                    BuildPages(
                        title: 'Welcome to\nMsgMee',
                        index: 1,
                        imageUrl: 'assets/onboarding1.svg',
                        descriptionText:
                            'Connecting with friends in a secure, fast and reliable way.'),
                    BuildPages(
                        title: 'Empower Your\nVoice ',
                        index: 2,
                        imageUrl: 'assets/onboarding2.svg',
                        descriptionText:
                            'Engage with your friends,\nbuild relationships.'),
                    BuildPages(
                        title: 'Be The\nPresenter',
                        index: 3,
                        imageUrl: 'assets/onboarding3.svg',
                        descriptionText:
                            'Join MsgMee, and become\npart of a growing community.'),
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        animatedScreenNavigator(context, MsgmeeScreen());
                      },
                      child: Text('Skip',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    GestureDetector(
                        onTap: isLastPage
                            ? () {
                                animatedScreenNavigator(
                                    context, WelcomeScreen());
                              }
                            : () {
                                pagecontroller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                        child: Container(
                          height: 41,
                          padding: EdgeInsets.only(left: 15, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF93CA65),
                              border: Border.all(
                                  color: Color(0xFF93CA65), width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: AppColors.white),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
