import 'package:flutter/material.dart';

class OptionsModel {
  final IconData imageUrl;
  final String title;
  final VoidCallback clickAction;

  OptionsModel(
      {required this.imageUrl, required this.title, required this.clickAction});
}

List<OptionsModel> options = [
  OptionsModel(
      imageUrl: Icons.message_outlined, title: 'Chat', clickAction: () {}),
  OptionsModel(
      imageUrl: Icons.videocam_outlined, title: 'Video', clickAction: () {}),
  OptionsModel(
      imageUrl: Icons.phone_outlined, title: 'Audio', clickAction: () {}),
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
                    Icon(options[index].imageUrl),
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
