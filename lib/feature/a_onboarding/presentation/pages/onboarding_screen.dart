// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:msgmee/domain/models/onboarding_data_model.dart';
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
                  image: AssetImage('assets/onboarding_bg.png'))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .85,
                  child: PageView.builder(
                      padEnds: false,
                      controller: pagecontroller,
                      onPageChanged: (index) {
                        setState(() {
                          isLastPage = index == 2;
                        });
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return BuildPages(
                            title: data[index].title,
                            index: data[index].index,
                            imageUrl: data[index].imageUrl,
                            descriptionText: data[index].descriptionText);
                      })),
              Center(
                  child: SmoothPageIndicator(
                      controller: pagecontroller,
                      count: 3,
                      onDotClicked: (index) => pagecontroller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut),
                      effect: ExpandingDotsEffect(
                          dotHeight: 7,
                          dotWidth: 7,
                          spacing: 5,
                          dotColor: AppColors.primaryColor.withOpacity(.5),
                          activeDotColor: AppColors.primaryDarkColor))),
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
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 10, top: 5, bottom: 5),
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
                              Icon(Icons.arrow_forward, color: AppColors.white)
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
