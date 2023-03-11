import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/custom_theme.dart';

class OptionsModel {
  final String title;
  bool isSelected;

  OptionsModel({
    required this.title,
    required this.isSelected,
  });
}

List<OptionsModel> options = [
  OptionsModel(
    title: 'Vibrate only',
    isSelected: false,
  ),
  OptionsModel(
    title: 'Tone only',
    isSelected: false,
  ),
  OptionsModel(
    title: 'Vibrate & Tone ',
    isSelected: false,
  ),
  OptionsModel(
    title: 'Silent',
    isSelected: false,
  ),
];

class NotificationBottomSheet extends StatefulWidget {
  const NotificationBottomSheet({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<NotificationBottomSheet> createState() =>
      _NotificationBottomSheetState();
}

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 280.h,
          decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: CustomTheme.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text(widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          tileColor: CustomTheme.seconderyColor,
                          selectedTileColor: CustomTheme.seconderyColor,
                          onTap: () {
                            options[index].isSelected =
                                !options[index].isSelected;
                            setState(() {});
                          },
                          leading: Text(
                            options[index].title,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          trailing: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: CustomTheme.white,
                                border: Border.all(
                                    color: CustomTheme.primaryColor, width: 1),
                                borderRadius: BorderRadius.circular(100)),
                            child: options[index].isSelected
                                ? Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: CustomTheme.primaryColor,
                                        border: Border.all(
                                            color: CustomTheme.white, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  )
                                : Container(),
                          ),
                        ),
                        index == options.length - 1
                            ? Container()
                            : Divider(
                                color: CustomTheme.primaryColor,
                                height: 0,
                              ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
