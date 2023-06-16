import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/colors.dart';

class OptionsModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  bool isSelected;

  OptionsModel({
    required this.title,
    required this.isSelected,
    required this.imageUrl,
    required this.subtitle,
  });
}

List<OptionsModel> options = [
  OptionsModel(
      title: 'Savannah Nguyen',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600',
      subtitle: 'savannah_nguyen123@gmail.com'),
  OptionsModel(
      title: 'Wade Warren',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600',
      subtitle: 'dummy_email@gmail.com'),
  OptionsModel(
      title: 'Annette Black',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600',
      subtitle: 'dummy_email@gmail.com'),
  OptionsModel(
      title: 'Marvin McKinney',
      isSelected: true,
      imageUrl:
          'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600',
      subtitle: 'dummy_email@gmail.com'),
];

class ChooseAccountBottomSheet extends StatefulWidget {
  const ChooseAccountBottomSheet({super.key});

  @override
  State<ChooseAccountBottomSheet> createState() =>
      _ChooseAccountBottomSheetState();
}

class _ChooseAccountBottomSheetState extends State<ChooseAccountBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 380.h,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
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
              Text('Choose Google Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: options[index].isSelected
                              ? AppColors.seconderyColor1
                              : Colors.transparent,
                          child: ListTile(
                            tileColor: AppColors.seconderyColor,
                            selectedTileColor: AppColors.seconderyColor,
                            onTap: () {
                              options[index].isSelected =
                                  !options[index].isSelected;
                              setState(() {});
                            },
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.grey,
                              backgroundImage:
                                  NetworkImage(options[index].imageUrl),
                            ),
                            title: Text(
                              options[index].title,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              options[index].subtitle,
                              style: TextStyle(
                                color: AppColors.iconColor,
                                fontSize: 11,
                              ),
                            ),
                            trailing: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(100)),
                              child: options[index].isSelected
                                  ? Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          border: Border.all(
                                              color: AppColors.white, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.primaryColor,
                          height: 0,
                        ),
                      ],
                    );
                  }),
              SizedBox(height: 24),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add new account',
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 16),
                  )),
              SizedBox(height: 24),
            ],
          ),
        ));
  }
}
