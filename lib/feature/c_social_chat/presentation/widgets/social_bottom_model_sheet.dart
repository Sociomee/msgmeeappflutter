class ChatOptionsModel {
  final String option;

  final int id;
  ChatOptionsModel({
    required this.option,
    required this.id,
  });
}

// class SocialBottomModelSheet extends StatelessWidget {
//   const SocialBottomModelSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<ChatOptionsModel> options = [
//       ChatOptionsModel(
//           id: 1,
//           option: 'New Message',
//           clickAction: () {
//             screenNavigator(context, NewMessageScreen());
//           }),
//       ChatOptionsModel(id: 2, option: 'Make a Call', clickAction: () {}),
//       ChatOptionsModel(id: 3, option: 'Create New Group', clickAction: () {}),
//       ChatOptionsModel(
//           id: 4,
//           option: 'Create a Broadcast',
//           clickAction: () {
//             animatedScreenNavigator(context, AddParticipantsScreen());
//           }),
//       ChatOptionsModel(
//           id: 5,
//           option: 'Sync your account to web panel',
//           clickAction: () {
//             screenNavigator(context, LinkedDevicesScreen());
//           }),
//       ChatOptionsModel(
//           id: 6, option: 'Archived Chats List', clickAction: () {}),
//       ChatOptionsModel(
//           id: 7, option: 'Sync your SocioMee connections', clickAction: () {}),
//       ChatOptionsModel(
//           id: 8,
//           option: 'Settings',
//           clickAction: () {
//             screenNavigator(context, SettingScreen());
//           }),
//       ChatOptionsModel(id: 9, option: 'Logout', clickAction: () {}),
//     ];
//     return MediaQuery(
//       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//         child: Container(
//           height: 398.w,
//           decoration: BoxDecoration(
//               color: AppColors.white, borderRadius: BorderRadius.circular(25)),
//           child: Column(
//             children: [
//               Container(
//                 height: 4,
//                 width: 80,
//                 margin: EdgeInsets.only(top: 15),
//                 decoration: BoxDecoration(
//                     color: AppColors.grey,
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: options.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: options[index].clickAction,
//                       splashColor: AppColors.seconderyColor,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 15, bottom: 15, left: 24),
//                                   child: Text(
//                                     options[index].option,
//                                     style: TextStyle(
//                                         color: AppColors.bottomSheettextColor),
//                                   ),
//                                 ),
//                                 Divider(height: 0, color: AppColors.grey)
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
