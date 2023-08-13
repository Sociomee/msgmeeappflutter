import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../theme/colors.dart';

class SyncInviteScreen extends StatefulWidget {
  const SyncInviteScreen({super.key});

  @override
  State<SyncInviteScreen> createState() => _SyncInviteScreenState();
}

class _SyncInviteScreenState extends State<SyncInviteScreen> {
  bool readReceipt = false;
  bool invite = false;
  late TextEditingController controller;
  bool enable = false;
  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      enableBtn();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  enableBtn() {
    setState(() {
      enable = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20,
                )),
          ),
          leadingWidth: 45,
          titleSpacing: 0,
          title: Text(
            'Syncing and Invite',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )),
      body: Column(
        children: [
          ListTile(
            onTap: () {},
            title: Text(
              'Sync to SocioMee',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You can sync your SocioMee Connections',
              style: TextStyle(fontSize: 12),
            ),
            trailing: SizedBox(
              width: 51,
              child: FlutterSwitch(
                switchBorder: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0.w,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.white,
                inactiveToggleColor: AppColors.primaryColor,
                width: 51.0.w,
                height: 26.0.h,
                toggleSize: 23.0.sp,
                value: readReceipt,
                borderRadius: 30.0,
                padding: 2.0,
                onToggle: (val) {
                  setState(() {
                    readReceipt = !readReceipt;
                  });
                },
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Invite',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You can invite your connections from SocioMee ',
              style: TextStyle(fontSize: 12),
            ),
            trailing: SizedBox(
              width: 51,
              child: FlutterSwitch(
                switchBorder: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0.w,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.white,
                inactiveToggleColor: AppColors.primaryColor,
                width: 51.0.w,
                height: 26.0.h,
                toggleSize: 23.0.sp,
                value: invite,
                borderRadius: 30.0,
                padding: 2.0,
                onToggle: (val) {
                  setState(() {
                    invite = !invite;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 43,
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primaryColor, width: 1)),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: AppColors.lightgrey,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: enable ? AppColors.primaryColor : Color(0xFFDADADA),
                  ),
                  child: Text(
                    'Invite',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
