import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/presentation/storage_settings/widgets/mobile_network_tab.dart';
import 'package:msgmee/presentation/storage_settings/widgets/romaing_network_tab.dart';
import 'package:msgmee/presentation/storage_settings/widgets/wifi_network_tab.dart';

import '../../theme/custom_theme.dart';

class NetworkUsageScreen extends StatefulWidget {
  const NetworkUsageScreen({super.key});

  @override
  State<NetworkUsageScreen> createState() => _NetworkUsageScreenState();
}

class _NetworkUsageScreenState extends State<NetworkUsageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomTheme.black,
            )),
        title: Text(
          'Network Usage',
          style: TextStyle(color: CustomTheme.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.8)),
              ),
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: CustomTheme.primaryColor,
                labelColor: CustomTheme.primaryColor,
                unselectedLabelColor: CustomTheme.grey,
                controller: _controller,
                tabs: [
                  Tab(
                    icon: Text(
                      'Mobile',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Wi-Fi',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Roaming',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 570.h,
              child: TabBarView(controller: _controller, children: [
                MobileNetworkTab(),
                WifiNetworkTab(),
                RoamingNetworkTab()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
