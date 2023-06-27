import 'package:flutter/material.dart';

import '../../../../../data/model/participants_model.dart';
import '../../../../../theme/colors.dart';

class BlockedContactsPage extends StatelessWidget {
  const BlockedContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text(
            'Blocked Contacts',
            style: TextStyle(color: AppColors.black),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Total blocked people (56)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: blockedUserlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
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
                            blockedUserlist[index].username[0],
                            style:
                                TextStyle(color: AppColors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          blockedUserlist[index].username,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
