import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import 'package:msgmee/helper/string_ext.dart';
import '../../../../data/model/msgmee_user_model.dart';
import '../../../../helper/navigator_function.dart';
import '../pages/chat_screen/chat_screen.dart';

class AllconnectionsWidget extends StatelessWidget {
  const AllconnectionsWidget({super.key, required this.list});
  final List<User> list;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 651.h,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                screenNavigator(
                    context,
                    ChatScreen(
                      name: list[index].fullName!,
                      imageUrl: list[index]
                          .otherProfileImage
                          .toString()
                          .toProfileUrl(),
                      senderId: 'false',
                      hasStory: false,
                      lastOnline: '',
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ChatProfileWidget(
                      imageUrl: list[index]
                          .otherProfileImage
                          .toString()
                          .toProfileUrl(),
                      isOnline: 'false',
                      hasStory: false,
                      radius: 20,
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list[index].fullName!,
                            style: TextStyle(fontSize: 14.sp)),
                        Text(list[index].username!,
                            style: TextStyle(fontSize: 10))
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    if (list[index].linkedTo!.toLowerCase() == 'msgmee')
                      SvgPicture.asset(
                        'assets/msgmee.svg',
                      ),
                    if (list[index].linkedTo!.toLowerCase() == 'sociomee')
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SvgPicture.asset(
                          'assets/sociomee.svg',
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
