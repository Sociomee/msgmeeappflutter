import 'package:flutter/material.dart';
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
  bool isLastPage = false;
  List<String> images = [];
  @override
  void initState() {
    pagecontroller = PageController();
    for (var e in data) {
      images.add(e.imageUrl);
    }
    super.initState();
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> preloadImages() async {
    for (final imageUrl in images) {
      await precacheImage(NetworkImage(imageUrl), context);
    }
    setState(() {
      // Images are preloaded and ready to use
    });
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
              image: AssetImage('assets/onboarding/onboarding_bg.png'),
            ),
          ),
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
                            imageUrl: images[index],
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
