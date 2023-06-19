import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/theme/colors.dart';

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
          child: Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
        title: Text('Contact', style: TextStyle(color: AppColors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              if (selected.isNotEmpty) {
                context.read<ShowContactTextField>().toggleValue();
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
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 13),
                      prefixIcon: Icon(Icons.search, color: AppColors.grey),
                      border: InputBorder.none))),
          Divider(height: 0, color: AppColors.grey, thickness: .7),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      selected.add(index);
                    });
                  },
                  onTap: () {
                    setState(() {
                      selected.remove(index);
                    });
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
                                    contacts[index].name[0],
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contacts[index].name,
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