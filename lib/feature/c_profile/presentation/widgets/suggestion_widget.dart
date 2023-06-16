import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

// ignore: must_be_immutable
class SuggestionWidget extends StatelessWidget {
  SuggestionWidget({super.key});

  List<String> suggestion = [
    '@anurag_saini012',
    '@anuragSaini148',
    '@anurag.saini012',
    '@anuragSaini148',
    '@anurag_saini012',
    '@anuragSaini148',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Suggestions:', style: TextStyle(color: AppColors.grey)),
              Text('Next suggestions', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 129 / 26,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: suggestion.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 26,
                  width: 136,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(suggestion[index],
                      style: TextStyle(color: Color(0XFF333333))),
                );
              })
        ],
      ),
    );
  }
}
