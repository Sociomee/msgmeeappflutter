import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/model/all_connections_model.dart';
import '../../../../theme/colors.dart';
import '../widgets/all_connections_widget.dart';
import '../widgets/contact_filtering_design.dart';
import '../widgets/invite_friends_list.dart';
import '../widgets/social_bottom_model_sheet.dart';

List<ChatOptionsModel> options = [
  ChatOptionsModel(id: 1, option: 'All Contacts'),
  ChatOptionsModel(id: 2, option: 'MsgMee Contacts'),
  ChatOptionsModel(id: 3, option: 'SocioMee Users'),
];

List<String> alphabats = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  late TextEditingController searchController;
  List<AllConnectionsModel> filterdList = [];
  bool show = false;
  int currentindex = 0;
  double top = 17;
  @override
  void initState() {
    searchController = TextEditingController();
    filterdList = List.from(dummyconnections);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: 20.h,
              ),
            )),
        leadingWidth: 30.w,
        titleSpacing: 15.w,
        title: Text(
          'New message',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 30, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 17.h,
                      width: 15.w,
                      child: Center(
                          child: SvgPicture.asset('assets/Search.svg',
                              fit: BoxFit.cover))),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            filterdList = List.from(dummyconnections);
                          } else {
                            filterdList = dummyconnections
                                .where((model) => model.connectionName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          }
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Search......',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Niramit',
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  PopupMenuButton(
                    icon: SvgPicture.asset('assets/filter.svg'),
                    offset: Offset(-20, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.white,
                    itemBuilder: (context) {
                      return options
                          .map(
                            (e) => PopupMenuItem(
                                value: e.id,
                                child: Text(
                                  e.option,
                                  style: TextStyle(
                                    color: Color(0xFF4E4E4E),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                          )
                          .toList();
                    },
                    onSelected: (value) {
                      if (value == 1) {
                        setState(() {
                          filterdList = List.from(dummyconnections);
                        });
                      } else if (value == 2) {
                        setState(() {
                          filterdList = dummyconnections
                              .where((model) => model.connectionType
                                  .toLowerCase()
                                  .contains('MsgMee'.toLowerCase()))
                              .toList();
                        });
                      } else if (value == 3) {
                        setState(() {
                          filterdList = dummyconnections
                              .where((model) => model.connectionType
                                  .toLowerCase()
                                  .contains('SocioMee'.toLowerCase()))
                              .toList();
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Divider(height: 0, color: AppColors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Connections',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              flex: 110,
                              child: AllconnectionsWidget(list: filterdList)),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 1,
                              child: ListView.separated(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentindex = index;

                                        show = !show;
                                      });
                                      print(alphabats[index]);
                                    },
                                    child: Container(
                                      height: 3,
                                      width: 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColors.darkbtnColor),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 23.h);
                                },
                                itemCount: 26,
                              )),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text('Invite Contacts',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 24),
                      InviteFriendsList()
                    ],
                  ),
                  show
                      ? Positioned(
                          top: top,
                          right: 3,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                show = !show;
                                filterdList = dummyconnections
                                    .where((model) => model.connectionName
                                        .toLowerCase()
                                        .contains(alphabats[currentindex]
                                            .toLowerCase()))
                                    .toList();
                              });
                            },
                            child: ContactFilteringDesign(
                                text: alphabats[currentindex]),
                          ))
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
