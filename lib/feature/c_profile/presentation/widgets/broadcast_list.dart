import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

class BroadCastList extends StatelessWidget {
  const BroadCastList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
        ),
        title: Text(
          'My Broadcasts',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 13,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    splashColor: AppColors.seconderyColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              onTap: () {},
                              child: SvgPicture.asset('assets/broadcast.svg')),
                          SizedBox(width: 13),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  index == 1
                                      ? "Eid Broadcast"
                                      : index == 2
                                          ? 'Diwali Broadcast'
                                          : 'Christmas Broadcast',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 8),
                              Text('Alam, Saurabh, Taha Jamal, Anshuman...',
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.grey)),
                            ],
                          ),
                          Spacer(),
                          Text('2w ago',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
