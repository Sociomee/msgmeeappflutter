import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/model/forward_user_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/chat_profile_widget.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../common_widgets/checkbox_widget.dart';

class ForwardMessagePage extends StatefulWidget {
  const ForwardMessagePage({super.key});

  @override
  State<ForwardMessagePage> createState() => _ForwardMessagePageState();
}

class _ForwardMessagePageState extends State<ForwardMessagePage> {
  late TextEditingController searchController;
  List<ForwardUserModel> filterdList = [];
  int selected = 0;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filterdList = List.from(userslist);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                ),
              )),
          leadingWidth: 40,
          titleSpacing: 0,
          elevation: 1,
          title: Text(
            'Forward to',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 18, right: 10),
                child: Text(
                  'SEND',
                  style: TextStyle(
                    color: Color(0xFF81C14B),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      color: AppColors.lightgrey.withOpacity(.5),
                      offset: Offset(0, 5),
                      spreadRadius: 0,
                      blurRadius: 10)
                ]),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              filterdList = List.from(userslist);
                            } else {
                              filterdList = userslist
                                  .where((model) => model.username
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Search......',
                            contentPadding: EdgeInsets.only(top: 13),
                            prefixIcon: SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/Search_black.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            border: InputBorder.none))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$selected Selected',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        for (var i = 0; i < userslist.length; i++) {
                          setState(() {
                            userslist[i].selected = true;
                            selected = userslist
                                .where((model) => model.selected
                                    .toString()
                                    .toLowerCase()
                                    .contains(true.toString().toLowerCase()))
                                .toList()
                                .length;
                          });
                        }
                      },
                      child: Text(
                        'Select All',
                        style: TextStyle(
                          color: Color(0xFF81C14B),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filterdList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ChatProfileWidget(
                              radius: 20,
                              imageUrl: filterdList[index].profilepic,
                              isOnline: false,
                              hasStory: false),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  filterdList[index].username,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF151624),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                filterdList[index].platform,
                                style: TextStyle(
                                  color: Color(0xFFC4C4C4),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          CheckBoxWidget(
                            selected: filterdList[index].selected,
                            onChange: (e) {
                              setState(() {
                                filterdList[index].selected =
                                    !filterdList[index].selected;
                                selected = userslist
                                    .where((model) => model.selected
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                            true.toString().toLowerCase()))
                                    .toList()
                                    .length;
                              });
                            },
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
