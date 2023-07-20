import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../theme/colors.dart';

List invitelist = [
  'Guy Hawkins',
  'Ralph Edwards',
  'Cameron Williamson',
  'Annette Black',
  'Eleanor Pena',
  'Esther Howard',
  'Albert Flores',
  'Arlene McCoy',
  'Jenny Wilson',
  'Kathryn Murphy',
];

class InviteFriendsList extends StatelessWidget {
  const InviteFriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: invitelist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:
                          index % 2 == 0 ? AppColors.darkgreen : AppColors.blue,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    invitelist[index][0],
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  invitelist[index],
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/invite.svg', height: 16.h),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Invite',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
