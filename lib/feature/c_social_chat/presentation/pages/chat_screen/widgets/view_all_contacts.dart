import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/common_widgets/mx_appbar.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../../common_widgets/cache_image_provider.dart';

class ViewAllContactsScreen extends StatelessWidget {
  const ViewAllContactsScreen({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MAppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 16,
          ),
        ),
        title: Text(
          'View contacts',
          style: TextStyle(color: AppColors.black, fontSize: 18),
        ),
      ),
      body: ListView.builder(
          itemCount: images.length,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.cover,
                              cacheManager: CustomCacheManager.cacheManager,
                              key: Key(images[index]),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Joy Arthur',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Add',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.lightgrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/msg.svg',
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+912384747272',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mobile',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/video.svg',
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset('assets/call.svg')
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (index != images.length - 1)
                    Divider(
                      height: 10,
                      thickness: 8,
                      color: AppColors.lightgrey1,
                    )
                ],
              ),
            );
          }),
    );
  }
}
