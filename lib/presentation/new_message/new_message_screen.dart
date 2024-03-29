import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../theme/custom_theme.dart';
import 'widget/all_connections_widget.dart';
import 'widget/bottom_options_widget.dart';
import 'widget/invite_friends_list.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomTheme.black,
            )),
        title: Text(
          'New message',
          style: TextStyle(color: CustomTheme.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: CustomTheme.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 30, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    color: CustomTheme.grey,
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'search ...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  IconButton(
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
                              return BottomOptionsWidget();
                            });
                      },
                      icon: Icon(Icons.tune_outlined))
                ],
              ),
            ),
            Divider(
              height: 0,
              color: CustomTheme.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Connections',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AllconnectionsWidget(),
                  SizedBox(height: 30),
                  Text('Invite Friends',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  InviteFriendsList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
