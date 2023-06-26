import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

List<String> interestList = [
  'Photography',
  'Books',
  'Reading',
  'Gaming',
  'Song',
  'Movies',
  'Travelling',
  'Writing',
  'Philosophy',
  'Astrology',
  'Animator',
  'Animals',
  'Acting',
  'Sleeping',
  'Dancing',
  'Story',
  'Cinematography',
  'Director',
  'Drawing',
  'Drawing',
  'Drawing'
];

class ChooseInterestBottomSheet extends StatelessWidget {
  const ChooseInterestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text('Choose your Interests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Please select ',
                    style: TextStyle(fontSize: 16, color: AppColors.black)),
                TextSpan(
                    text: 'at least 3 interests',
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primaryColor)),
                TextSpan(
                    text: ' for a ',
                    style: TextStyle(fontSize: 16, color: AppColors.black)),
              ])),
              Text('better in-app experience', style: TextStyle(fontSize: 14)),
              // SizedBox(height: 37),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 103 / 36,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(interestList.length, (index) {
                    return Container(
                        height: 36,
                        width: 103,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.lightgrey1,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(interestList[index]));
                  }),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
