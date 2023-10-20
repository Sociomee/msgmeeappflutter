import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/calls_tab/widget/delete_calls_bottomsheet.dart';
import '../../../../../../data/model/dummy_phone_model.dart';
import '../../../../../../theme/colors.dart';
import '../../../../../f_call/presentation/pages/single_call_screen.dart';
import '../../../widgets/chat_profile_widget.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyPhoneData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                onLongPress: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return DeleteCallBottomSheet();
                      });
                },
                splashColor: AppColors.seconderyColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChatProfileWidget(
                          imageUrl: dummyPhoneData[index].imageUrl,
                          isOnline: 'false',
                          hasStory: false),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dummyPhoneData[index].name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              dummyPhoneData[index].calltype == 0
                                  ? Image.asset('assets/call_missed.png')
                                  : dummyPhoneData[index].calltype == 1
                                      ? Image.asset('assets/call_incoming.png')
                                      : Image.asset('assets/call_outgoing.png'),
                              Text(dummyPhoneData[index].message,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: dummyPhoneData[index].calltype == 0
                                          ? AppColors.errorRedColor
                                          : AppColors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dummyPhoneData[index].time,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                          SizedBox(height: 13),
                          Row(
                            children: [
                              Image.asset('assets/video.png'),
                              SizedBox(width: 30),
                              InkWell(
                                  splashColor: AppColors.seconderyColor,
                                  onTap: () {
                                    animatedScreenNavigator(
                                        context,
                                        SingleCallScreen(
                                            imageUrl: dummyPhoneData[index]
                                                .imageUrl));
                                  },
                                  child: Image.asset('assets/call.png')),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 0, color: AppColors.grey),
            ],
          );
        });
  }
}
