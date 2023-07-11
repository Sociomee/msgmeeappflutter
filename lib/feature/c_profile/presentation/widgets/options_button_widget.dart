import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionsModel {
  final String imageUrl;
  final String title;
  final VoidCallback clickAction;

  OptionsModel(
      {required this.imageUrl, required this.title, required this.clickAction});
}

List<OptionsModel> options = [
  OptionsModel(imageUrl: 'assets/msg.svg', title: 'Chat', clickAction: () {}),
  OptionsModel(
      imageUrl: 'assets/video.svg', title: 'Video', clickAction: () {}),
  OptionsModel(imageUrl: 'assets/call.svg', title: 'Audio', clickAction: () {}),
];

class OptionsButtomWidgets extends StatelessWidget {
  const OptionsButtomWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      options[index].imageUrl,
                      height: 20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      options[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
