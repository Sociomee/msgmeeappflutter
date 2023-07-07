import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/colors.dart';
import '../../cubit/choose_solid_color_cubit.dart';

List<Color> wallpapersColor = [
  AppColors.wallpaperColor1,
  AppColors.wallpaperColor2,
  AppColors.wallpaperColor3,
  AppColors.wallpaperColor4,
  AppColors.wallpaperColor5,
  AppColors.wallpaperColor6,
  AppColors.wallpaperColor7,
  AppColors.wallpaperColor8,
  AppColors.wallpaperColor9,
  AppColors.wallpaperColor10,
  AppColors.wallpaperColor11,
  AppColors.wallpaperColor12,
];

class SolidColorPage extends StatelessWidget {
  const SolidColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
        title: Text(
          'Solid Color',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: Column(
        children: [
          GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 138 / 180,
              children: List.generate(wallpapersColor.length, (index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<ChooseSolidColorCubit>()
                        .chooseColor(wallpapersColor[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 180,
                    width: 138,
                    decoration: BoxDecoration(color: wallpapersColor[index]),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
