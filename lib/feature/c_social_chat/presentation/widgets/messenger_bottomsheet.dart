// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class MessengerOption {
  final String title;
  bool clicked;
  MessengerOption({
    required this.title,
    required this.clicked,
  });
}

List<MessengerOption> options = [
  MessengerOption(title: 'All', clicked: true),
  MessengerOption(title: "Group List (12)", clicked: false),
  MessengerOption(title: "MsgMee User", clicked: false),
  MessengerOption(title: "SocioMee Users", clicked: false),
  MessengerOption(title: "Broadcast", clicked: false),
];

class MessengerOptionsBottomSheet extends StatefulWidget {
  const MessengerOptionsBottomSheet({super.key});

  @override
  State<MessengerOptionsBottomSheet> createState() =>
      _MessengerOptionsBottomSheetState();
}

class _MessengerOptionsBottomSheetState
    extends State<MessengerOptionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          options[index].title,
                          style: TextStyle(
                            color: Color(0xFF4E4E4E),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            activeColor: AppColors.primaryColor,
                            value: options[index].clicked,
                            onChanged: (w) {
                              setState(() {
                                options[index].clicked = w!;
                              });
                            }),
                      ],
                    ),
                  ),
                  options.length - 1 == index
                      ? Container()
                      : Divider(
                          color: AppColors.lightgrey, height: 0, thickness: 1)
                ],
              );
            }),
      ],
    );
  }
}
