import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/a_onboarding/cubit/onboarding/onboarding_cubit.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../domain/models/onboarding_data_model.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../widgets/build_page.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pagecontroller;
  // bool isLastPage = false;
  List<String> images = [];
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
  void didChangeDependencies() {
    log('changing dependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight * .85;
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/onboarding/onboard_bg${state.currentIndex}.png'),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: height,
                      child: PageView.builder(
                          padEnds: false,
                          controller: pagecontroller,
                          onPageChanged: (index) {
                            context
                                .read<OnboardingCubit>()
                                .getCurrentIndex(index);
                          },
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return BuildPages(
                              title: data[index].title,
                              index: data[index].index,
                              imageUrl: data[index].imageUrl,
                              descriptionText: data[index].descriptionText,
                            );
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
                            animatedScreenNavigator(context, WelcomeScreen());
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
                            onTap: state.currentIndex == 3
                                ? () {
                                    animatedScreenNavigator(
                                        context, WelcomeScreen());
                                  }
                                : () {
                                    pagecontroller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
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
                                  Icon(Icons.arrow_forward,
                                      color: AppColors.white)
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
      },
    );
  }
}
