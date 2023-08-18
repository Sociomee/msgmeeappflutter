import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../../data/model/participants_model.dart';
import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';
import 'broadcast_chat_screen.dart';
import 'widget/text_field_widget.dart';

class BroadcastInfo extends StatefulWidget {
  const BroadcastInfo({super.key, required this.editscreen});
  final bool editscreen;
  @override
  State<BroadcastInfo> createState() => _BroadcastInfoState();
}

class _BroadcastInfoState extends State<BroadcastInfo> {
  late TextEditingController nameController;
  late TextEditingController summaryController;
  int remainchar = 25;
  int remainchar1 = 180;
  bool isSelected = false;
  @override
  void initState() {
    nameController = TextEditingController();
    summaryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          titleSpacing: 5,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 18,
                ),
              )),
          title: Text(
            'Broadcast Info',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            widget.editscreen
                ? TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ))
                : TextButton(
                    onPressed: () {
                      animatedScreenReplaceNavigator(
                          context, BroadCastChatScreen());
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 26),
                  BroadcastTextFieldWidget(
                    title: 'Name*',
                    hintText: 'Broadcast Name',
                    controller: nameController,
                    onChanged: (e) {
                      setState(() {
                        remainchar = 25 - nameController.text.length;
                      });
                    },
                    remainChar: remainchar.toString(),
                  ),
                  BroadcastTextFieldWidget(
                    title: 'Summary',
                    hintText: 'Brief description',
                    controller: summaryController,
                    onChanged: (e) {
                      setState(() {
                        remainchar1 = 180 - summaryController.text.length;
                      });
                    },
                    remainChar: remainchar1.toString(),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.lightgrey, thickness: 2),
            ListTile(
              leading: Text('Mute Notification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              trailing: Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) =>
                        BorderSide(width: 1.0, color: AppColors.primaryColor),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  activeColor: AppColors.primaryColor,
                  value: isSelected,
                  onChanged: (w) {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  }),
            ),
            Divider(color: AppColors.lightgrey, thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text('Add more participants',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.borderColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.primaryColor)),
                        hintText: 'Search Participants...',
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.grey,
                        )),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [Spacer(), Text('12 Participant')],
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: blockedUserlist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: ChatProfileWidget(
                                imageUrl: blockedUserlist[index].imageUrl,
                                isOnline: false,
                                hasStory: false),
                            title: Text(blockedUserlist[index].username),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                blockedUserlist[index].isSelected
                                    ? Text('You',
                                        style: TextStyle(color: AppColors.blue))
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
