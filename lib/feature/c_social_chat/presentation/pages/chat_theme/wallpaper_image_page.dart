import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/choose_image_wallpaper_cubit.dart';

import '../../../../../theme/colors.dart';

List<String> wallpapers = [
  'https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  'https://images.pexels.com/photos/2098427/pexels-photo-2098427.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/3894157/pexels-photo-3894157.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/1906658/pexels-photo-1906658.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/937980/pexels-photo-937980.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/816608/pexels-photo-816608.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/2414036/pexels-photo-2414036.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/1707215/pexels-photo-1707215.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/719396/pexels-photo-719396.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/1535162/pexels-photo-1535162.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/1723637/pexels-photo-1723637.jpeg?auto=compress&cs=tinysrgb&w=600'
];

class WallPaparImagePage extends StatelessWidget {
  const WallPaparImagePage({super.key});

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
          'Wallpaper',
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
              children: List.generate(wallpapers.length, (index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<ChooseImageWallpaperCubit>()
                        .chooseImage(wallpapers[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 180,
                    width: 138,
                    decoration: BoxDecoration(),
                    child: Image.network(
                      wallpapers[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
