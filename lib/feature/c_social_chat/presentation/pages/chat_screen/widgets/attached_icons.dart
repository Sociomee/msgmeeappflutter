// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/doc_sending_page.dart';
import 'package:msgmee/helper/navigator_function.dart';

List<String> attachments = [
  'assets/attachment6.svg',
  'assets/attachment5.svg',
  'assets/attachment4.svg',
  'assets/attachment3.svg',
  'assets/attachment2.svg',
  'assets/attachment1.svg',
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
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
              } else if (index == 4) {
                animatedScreenNavigator(context, DocSendingPage());
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(attachments[index]),
              ],
            ),
          );
          // return Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          //   child: Container(
          //     height: 32,
          //     padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 20),
          //     decoration: BoxDecoration(
          //         color: icons[index].color,
          //         borderRadius: BorderRadius.circular(20)),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Image.asset(
          //           icons[index].icons,
          //           height: 34,
          //         ),
          //         Text(
          //           icons[index].title,
          //           style: TextStyle(color: AppColors.black),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        });
  }
}
