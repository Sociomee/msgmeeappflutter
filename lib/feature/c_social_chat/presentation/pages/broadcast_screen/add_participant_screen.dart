import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late TextEditingController controller;
  List<ParticipantsModel> filteredlist = [];
  @override
  void initState() {
    controller = TextEditingController();
    filteredlist = List.from(blockedUserlist);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
                  ),
                )),
            title: Text(
              'Add Participants',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    animatedScreenReplaceNavigator(
                        context, BroadcastInfo(editscreen: false));
                  },
                  child: Text(
                    'DONE',
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
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.grey,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                              child: SvgPicture.asset('assets/Search.svg'))),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                filteredlist = List.from(blockedUserlist);
                              } else {
                                filteredlist = blockedUserlist
                                    .where((model) => model.username
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              }
                            });
                          },
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
                            hintText: 'Search....',
                            hintStyle: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 12,
                              fontFamily: 'Niramit',
                              fontWeight: FontWeight.w400,
                            ),
                            focusColor: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
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
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                                child: SvgPicture.asset('assets/filter.svg'))),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: ChatProfileWidget(
                              imageUrl: filteredlist[index].imageUrl,
                              isOnline: true,
                              hasStory: false),
                          title: Text(filteredlist[index].username),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(filteredlist[index].usertype,
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
                                  value: filteredlist[index].isSelected,
                                  onChanged: (w) {
                                    setState(() {
                                      filteredlist[index].isSelected =
                                          !filteredlist[index].isSelected;
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
