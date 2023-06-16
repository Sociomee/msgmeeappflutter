import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import 'share_link_bottomSheet.dart';

List<String> contactList = [
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
  'Guy Hawkins',
  'Ralph Edwards',
  'Cameron Williamson'
];

class InviteContactScreen extends StatelessWidget {
  const InviteContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title:
              Text('Invite Contact', style: TextStyle(color: AppColors.black))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15),
                child: Text(
                  'Contact list',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: Container(
                          height: 44,
                          width: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? AppColors.darkgreen
                                  : AppColors.blue,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            contactList[index][0],
                            style:
                                TextStyle(color: AppColors.white, fontSize: 20),
                          ),
                        ),
                        title: Text(contactList[index]),
                        trailing: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return ShareLinkBottomSheet(
                                    showSociomee: true,
                                  );
                                });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_add,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Invite',
                                style: TextStyle(color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
