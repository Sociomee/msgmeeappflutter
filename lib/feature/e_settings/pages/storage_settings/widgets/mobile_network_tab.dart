import 'package:flutter/material.dart';
import 'package:msgmee/feature/e_settings/pages/storage_settings/widgets/title_widget.dart';

import 'network_usage_details.dart';

class MobileNetworkTab extends StatelessWidget {
  const MobileNetworkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          TitleWidget(title: 'PHOTOS'),
          NetworkUsageDetails(
            callsection: false,
          ),
          TitleWidget(title: 'VIDEOS'),
          NetworkUsageDetails(
            callsection: false,
          ),
          TitleWidget(title: 'GIF & STICKERS'),
          NetworkUsageDetails(
            callsection: false,
          ),
          TitleWidget(title: 'VOICE & VIDEO MESSAGE '),
          NetworkUsageDetails(
            callsection: false,
          ),
          TitleWidget(title: 'FILES'),
          NetworkUsageDetails(
            callsection: false,
          ),
          TitleWidget(title: 'CALLS'),
          NetworkUsageDetails(
            callsection: true,
          ),
        ],
      ),
    );
  }
}
