import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/group_chat_screen/group_qr_page.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/group_chat_screen/share_group_invitation_page.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../../common_widgets/mx_appbar.dart';
import '../../../../../theme/colors.dart';

class GroupInvitePage extends StatefulWidget {
  const GroupInvitePage({super.key});

  @override
  State<GroupInvitePage> createState() => _GroupInvitePageState();
}

class _GroupInvitePageState extends State<GroupInvitePage> {
  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 16,
            ),
          ),
        ),
        title: Text(
          'Invite Link',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Text(
            'Anyone with MsgMee can follow this link to join this group. Only share it with people you trust.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 35),
          Divider(height: 0, color: AppColors.lightgrey1, thickness: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/link1.svg'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'https://chat.msgmee.com/examplelink\nhauhfksdhvchsdus86dsycvsdy7',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Divider(height: 0, color: AppColors.lightgrey1, thickness: 4),
          GestureDetector(
            onTap: () {
              animatedScreenNavigator(context, ShareGroupInvitationPage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Text(
                'Share link via MsgMee',
                style: TextStyle(
                  color: Color(0xFF4E4E4E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Divider(height: 0, color: AppColors.lightgrey, thickness: .5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Text(
              'Share Link',
              style: TextStyle(
                color: Color(0xFF4E4E4E),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(height: 0, color: AppColors.lightgrey, thickness: .5),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text:
                      'https://chat.msgmee.com/examplelink\nhauhfksdhvchsdus86dsycvsdy7'));
              Widget toast = Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: AppColors.iconColor),
                child: Text(
                  "Link Copied to clipboard.",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
              fToast.showToast(
                  child: toast,
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: Duration(seconds: 2));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Text(
                'Copy Link',
                style: TextStyle(
                  color: Color(0xFF4E4E4E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Divider(height: 0, color: AppColors.lightgrey, thickness: .8),
          GestureDetector(
            onTap: () {
              animatedScreenNavigator(context, GroupQrPage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Text(
                'Generate QR code',
                style: TextStyle(
                  color: Color(0xFF4E4E4E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Divider(height: 0, color: AppColors.lightgrey, thickness: .5),
        ],
      ),
    );
  }
}
