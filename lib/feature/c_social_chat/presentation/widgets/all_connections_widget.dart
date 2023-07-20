import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import '../../../../data/model/all_connections_model.dart';
import '../../../../theme/colors.dart';

class AllconnectionsWidget extends StatelessWidget {
  const AllconnectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyconnections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatProfileWidget(
                    imageUrl: dummyconnections[index].imageUrl,
                    isOnline: dummyconnections[index].isOnline,
                    hasStory: false),
                SizedBox(width: 12.w),
                Text(
                  dummyconnections[index].connectionName,
                  style: TextStyle(fontSize: 14.sp),
                ),
                Spacer(),
                dummyconnections[index].connectionType == "SocioMee"
                    ? SvgPicture.asset(
                        'assets/sociomee.svg',
                        height: 14.h,
                        fit: BoxFit.cover,
                      )
                    : Container(),
                SizedBox(width: 5.w),
                SvgPicture.asset('assets/msgmee.svg',
                    height: 14.h, fit: BoxFit.cover),
              ],
            ),
          );
        });
  }
}
