import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/broadcast_screen/broadcast_info.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../../data/model/participants_model.dart';
import 'widget/filter_dropdown.dart';



class AddParticipantsScreen extends StatefulWidget {
  const AddParticipantsScreen({super.key});

  @override
  State<AddParticipantsScreen> createState() => _AddParticipantsScreenState();
}

class _AddParticipantsScreenState extends State<AddParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                )),
            title: Text(
              'Add Participants',
              style: TextStyle(color: AppColors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    animatedScreenReplaceNavigator(
                        context, BroadcastInfo(editscreen: false));
                  },
                  child: Text(
                    'DONE',
                    style: TextStyle(color: AppColors.primaryColor),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  // height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppColors.grey,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white),
                            ),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search....',
                            hintStyle:
                                TextStyle(color: AppColors.grey, fontSize: 17),
                            focusColor: AppColors.primaryColor,
                            suffixIcon: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return FilterBottomSheet();
                                    });
                              },
                              icon: Icon(
                                Icons.tune_outlined,
                                color: AppColors.black,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: blockedUserlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: ChatProfileWidget(
                              imageUrl: blockedUserlist[index].imageUrl,
                              isOnline: true,
                              hasStory: false),
                          title: Text(blockedUserlist[index].username),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(blockedUserlist[index].usertype,
                                  style: TextStyle(color: AppColors.grey)),
                              Checkbox(
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: 1.0,
                                        color: AppColors.primaryColor),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  activeColor: AppColors.primaryColor,
                                  value: blockedUserlist[index].isSelected,
                                  onChanged: (w) {
                                    setState(() {
                                      blockedUserlist[index].isSelected =
                                          !blockedUserlist[index].isSelected;
                                    });
                                  })
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          )),
    );
  }
}
