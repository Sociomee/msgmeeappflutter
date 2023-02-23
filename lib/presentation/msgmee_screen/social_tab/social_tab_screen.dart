import 'package:flutter/material.dart';

import 'widget/social_stoty_widget.dart';

class SocialTabScreen extends StatelessWidget {
  const SocialTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SocialStoryWidget()],
    );
  }
}
