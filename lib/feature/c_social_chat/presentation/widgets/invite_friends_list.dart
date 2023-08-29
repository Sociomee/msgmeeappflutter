import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/helper/get_contacts.dart';
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
    return FutureBuilder(
        future: getContactData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var contacts = snapshot.data;
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: contacts!.length,
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
                              color: index % 2 == 0
                                  ? AppColors.darkgreen
                                  : AppColors.blue,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            contacts[index].displayName![0],
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          contacts[index].displayName!,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/invite.svg',
                                  height: 16.h),
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
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
