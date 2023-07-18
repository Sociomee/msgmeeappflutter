import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../cubit/add_message/add_message_cubit.dart';

class ContactModel {
  final String name;
  final String number;

  ContactModel(this.name, this.number);
}

List<ContactModel> contacts = [
  ContactModel('Mohali', '0000000000'),
  ContactModel('Chandigarh', '0000054321'),
  ContactModel('Delhi', '0086425879'),
  ContactModel('Gurgaon', '0000000000'),
  ContactModel('Panchkula', '0000000000'),
  ContactModel('Jalandhar', '0000000000'),
  ContactModel('Amritsar', '0000000000'),
];

class AttachContactPage extends StatefulWidget {
  const AttachContactPage({super.key});

  @override
  State<AttachContactPage> createState() => _AttachContactPageState();
}

class _AttachContactPageState extends State<AttachContactPage> {
  List<int> selected = [];
  late TextEditingController searchController;
  List<ContactModel> filterdList = [];

  @override
  void initState() {
    searchController = TextEditingController();
    filterdList = List.from(contacts);
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
        ),
        leadingWidth: 40,
        titleSpacing: 5,
        title: Text(
            selected.isEmpty
                ? 'Contact'
                : 'Contact (${selected.length} Selected)',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            )),
        actions: [
          GestureDetector(
            onTap: () {
              if (selected.isNotEmpty && selected.length == 1) {
                context.read<ShowContactTextField>().toggleValue();
                Navigator.pop(context);
              } else if (selected.length > 1) {
                for (var i = 0; i < selected.length; i++) {
                  context.read<AddMessageCubit>().addMessage(ChatMessage(
                        messageContent: '',
                        messageType: 'sender',
                        msgStatus: 'send',
                        time: getCurrentTime(),
                        type: MessageType.multiplecontact,
                        numberofContact: selected.length,
                      ));
                }
                Navigator.pop(context);
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 10),
                child: Text('Next',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        filterdList = List.from(contacts);
                      } else {
                        filterdList = contacts
                            .where((model) => model.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Search contacts',
                      contentPadding: EdgeInsets.only(top: 13),
                      prefixIcon: SizedBox(
                        height: 12.h,
                        width: 12.w,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/Search.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      border: InputBorder.none))),
          Divider(height: 0, color: AppColors.grey, thickness: .7),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filterdList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (selected.contains(index)) {
                      setState(() {
                        selected.remove(index);
                      });
                    } else {
                      setState(() {
                        selected.add(index);
                      });
                    }
                  },
                  child: Container(
                    color: selected.contains(index)
                        ? AppColors.seconderyColor1
                        : Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 36,
                                  width: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    filterdList[index].name[0],
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filterdList[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('+91 ${contacts[index].number}')
                                  ],
                                ),
                                Spacer(),
                                SvgPicture.asset('assets/video.svg'),
                                SizedBox(width: 20),
                                SvgPicture.asset('assets/call.svg'),
                              ],
                            )),
                        Divider(
                            height: 0, color: AppColors.grey, thickness: .7),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
