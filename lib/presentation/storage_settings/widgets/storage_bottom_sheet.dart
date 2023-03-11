import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
import '../../../theme/custom_theme.dart';

class OptionsModel {
  final String option;
  bool isSelected;

  OptionsModel({required this.option, required this.isSelected});
}

List<OptionsModel> options = [
  OptionsModel(option: 'No Media', isSelected: false),
  OptionsModel(option: 'Image', isSelected: false),
  OptionsModel(option: 'Video', isSelected: false),
  OptionsModel(option: 'Audio', isSelected: true),
  OptionsModel(option: 'Documents', isSelected: false),
  OptionsModel(option: 'GIF & Stickers', isSelected: false),
];

class StorageBottomSheet extends StatefulWidget {
  const StorageBottomSheet({super.key, required this.title});
  final String title;
  @override
  State<StorageBottomSheet> createState() => _StorageBottomSheetState();
}

class _StorageBottomSheetState extends State<StorageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 400.h,
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
                          leading: Text(options[index].option),
                          trailing: Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 2.0,
                                    color: CustomTheme.primaryColor),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              activeColor: CustomTheme.primaryColor,
                              value: options[index].isSelected,
                              onChanged: (w) {}),
                        ),
                        index == options.length - 1
                            ? Container()
                            : Divider(
                                color: CustomTheme.primaryColor,
                                height: 0,
                              )
                      ],
                    );
                  }),
              SizedBox(height: 30),
              CustomButtonWidget(
                  title: 'Ok', color: CustomTheme.primaryColor, ontap: () {}),
            ],
          ),
        ));
  }
}
