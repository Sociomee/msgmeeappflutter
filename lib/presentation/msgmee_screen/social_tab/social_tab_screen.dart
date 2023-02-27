import 'package:flutter/material.dart';

import 'widget/social_chat_widget.dart';
import 'widget/social_stoty_widget.dart';

class SocialTabScreen extends StatelessWidget {
  const SocialTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SocialStoryWidget(),
          SocialchatWidget(),
        ],
      ),
    );
  }
}
