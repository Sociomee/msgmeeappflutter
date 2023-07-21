import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import '../../../../data/model/all_connections_model.dart';

class AllconnectionsWidget extends StatelessWidget {
  const AllconnectionsWidget({super.key, required this.list});
  final List<AllConnectionsModel> list;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 610.h,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChatProfileWidget(
                      imageUrl: list[index].imageUrl,
                      isOnline: list[index].isOnline,
                      hasStory: false),
                  SizedBox(width: 12.w),
                  Text(list[index].connectionName,
                      style: TextStyle(fontSize: 14.sp)),
                  Spacer(),
                  list[index].connectionType == "SocioMee"
                      ? SvgPicture.asset('assets/sociomee.svg',
                          height: 14.h, fit: BoxFit.cover)
                      : Container(),
                  SizedBox(width: 5.w),
                  SvgPicture.asset('assets/msgmee.svg',
                      height: 14.h, fit: BoxFit.cover),
                ],
              ),
            );
          }),
    );
  }
}
