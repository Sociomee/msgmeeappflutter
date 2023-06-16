import 'package:flutter/material.dart';

import 'widget/call_widget.dart';

class CallTabScreen extends StatelessWidget {
  const CallTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CallWidget(),
        ],
      ),
    );
  }
}
