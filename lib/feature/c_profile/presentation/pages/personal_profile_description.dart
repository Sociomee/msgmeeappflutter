import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import 'edit_profile_screen.dart';

class PersonalPeofileDesc extends StatelessWidget {
  const PersonalPeofileDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings', style: TextStyle(fontSize: 33)),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Profile images',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {
                            animatedScreenNavigator(
                                context, EditProfileScreen());
                          },
                          child: Text('Edit',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.primaryColor)),
                        )
                      ],
                    ),
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 125,
                          width: 125,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightgrey,
                                offset: Offset(0, 0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.grey,
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '999',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Following',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '999',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Followers',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Divider(color: AppColors.lightgrey, thickness: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Henna Akhtar',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('Edit',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.primaryColor))
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('#username',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('F/ 24Yrs',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Divider(color: AppColors.lightgrey1, thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/sociomee.png',
                              height: 28,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Socio',
                                    style: TextStyle(
                                        color: AppColors.primaryDarkColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: 'Mee',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ]),
                            )
                          ],
                        ),
                        Text('Link',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.primaryColor))
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Link your sociomee account to sync all connections',
                      style: TextStyle(fontSize: 12, color: AppColors.grey),
                    )
                  ],
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Your Connections (128)',
                  style: TextStyle(color: AppColors.bottomSheettextColor),
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Privacy Settings',
                  style: TextStyle(color: AppColors.bottomSheettextColor),
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Messanger Settings',
                  style: TextStyle(color: AppColors.bottomSheettextColor),
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Notification Settings',
                  style: TextStyle(color: AppColors.bottomSheettextColor),
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Log Out',
                  style: TextStyle(color: AppColors.bottomSheettextColor),
                ),
              ),
              Divider(color: AppColors.lightgrey),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: AppColors.errorRedColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
