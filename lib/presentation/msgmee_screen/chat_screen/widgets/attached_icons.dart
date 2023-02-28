// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

List<CustomIcons> icons = [
  CustomIcons(
      icons: 'assets/audio.png',
      color: CustomTheme.audioiconColor,
      title: 'Audio'),
  CustomIcons(
      icons: 'assets/contact.png',
      color: CustomTheme.primaryColor,
      title: 'Contact'),
  CustomIcons(
      icons: 'assets/gallery.png',
      color: CustomTheme.mediaiconColor,
      title: 'Media'),
  CustomIcons(
      icons: 'assets/file.png',
      color: CustomTheme.dociconColor,
      title: 'Document'),
];

class CustomIcons {
  final String icons;
  final Color color;
  final String title;
  CustomIcons({
    required this.icons,
    required this.color,
    required this.title,
  });
}

class AttachedIcon extends StatelessWidget {
  const AttachedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: Container(
              height: 32,
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 20),
              decoration: BoxDecoration(
                  color: icons[index].color,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    icons[index].icons,
                    height: 34,
                  ),
                  Text(
                    icons[index].title,
                    style: TextStyle(color: CustomTheme.black),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
