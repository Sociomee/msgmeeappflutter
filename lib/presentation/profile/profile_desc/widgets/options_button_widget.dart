import 'package:flutter/material.dart';

class OptionsModel {
  final String imageUrl;
  final String title;
  final VoidCallback clickAction;

  OptionsModel(
      {required this.imageUrl, required this.title, required this.clickAction});
}

List<OptionsModel> options = [
  OptionsModel(
      imageUrl: 'assets/video.png', title: 'video', clickAction: () {}),
  OptionsModel(
      imageUrl: 'assets/comment.png', title: 'msgmee', clickAction: () {}),
  OptionsModel(imageUrl: 'assets/call.png', title: 'audio', clickAction: () {}),
  OptionsModel(imageUrl: 'assets/mic.png', title: 'mute', clickAction: () {}),
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
                    Image.asset(options[index].imageUrl, height: 24),
                    SizedBox(height: 15),
                    Text(options[index].title)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
