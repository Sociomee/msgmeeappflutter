import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import '../../../data/model/all_connections_model.dart';
import '../../../theme/colors.dart';

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
                SizedBox(
                  width: 12,
                ),
                Text(
                  dummyconnections[index].connectionName,
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    dummyconnections[index].connectionType,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          );
        });
  }
}
