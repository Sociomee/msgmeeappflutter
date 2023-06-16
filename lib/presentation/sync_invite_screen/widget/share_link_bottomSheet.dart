import 'package:flutter/material.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
import '../../../theme/colors.dart';

class Share {
  final String icon;
  final String title;
  Share({
    required this.icon,
    required this.title,
  });
}

List<Share> lists = [
  Share(icon: 'assets/email.png', title: 'Email'),
  Share(icon: 'assets/msg1.png', title: 'SMS'),
  Share(icon: 'assets/sociomee.png', title: 'SocioMee'),
];

class ShareLinkBottomSheet extends StatelessWidget {
  const ShareLinkBottomSheet({super.key, required this.showSociomee});
  final bool showSociomee;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text('Share Link', style: TextStyle(fontSize: 18)),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.only(left: 60, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 50),
                    Text('http://Msgmee.us',
                        style: TextStyle(color: AppColors.grey, fontSize: 14)),
                    SizedBox(width: 80),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.content_copy_outlined,
                            color: AppColors.primaryColor))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: showSociomee
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            Container(
                              width: 108,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(lists[0].icon),
                                  SizedBox(height: 9),
                                  Text(lists[0].title)
                                ],
                              ),
                            ),
                            Container(
                              width: 108,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(lists[1].icon),
                                  SizedBox(height: 9),
                                  Text(lists[1].title)
                                ],
                              ),
                            ),
                            Container(
                              width: 108,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(lists[2].icon),
                                  SizedBox(height: 9),
                                  Text(lists[2].title)
                                ],
                              ),
                            )
                          ])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            Container(
                              width: 108,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(lists[0].icon),
                                  SizedBox(height: 9),
                                  Text(lists[0].title)
                                ],
                              ),
                            ),
                            Container(
                              width: 108,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(lists[1].icon),
                                  SizedBox(height: 9),
                                  Text(lists[1].title)
                                ],
                              ),
                            ),
                          ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: CustomButtonWidget(
                    title: 'Ok', color: AppColors.primaryColor, ontap: () {}),
              )
            ],
          ),
        ));
  }
}
