import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../privacy_settings/widget/manage_storage_page.dart';
import 'network_usage_screen.dart';
import 'widgets/storage_bottom_sheet.dart';

class StorageSettingsScreen extends StatefulWidget {
  const StorageSettingsScreen({super.key});

  @override
  State<StorageSettingsScreen> createState() => _StorageSettingsScreenState();
}

class _StorageSettingsScreenState extends State<StorageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            elevation: 1,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
            title: Text(
              'Storage and Data Settings',
              style: TextStyle(color: AppColors.black),
            )),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                screenNavigator(context, ManageStoragePage());
              },
              title: Text('Manage Storage'),
              subtitle: Text(
                'Used',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Text('8 GB'),
            ),
            Divider(color: AppColors.lightgrey, thickness: 1),
            ListTile(
              onTap: () {
                screenNavigator(context, NetworkUsageScreen());
              },
              title: Text('Network Usage'),
              subtitle: Text(
                '8 Gb sent   12 Gb received ',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Text('8 GB'),
            ),
            Divider(color: AppColors.lightgrey, thickness: 1),
            ListTile(
              onTap: () {},
              title: Text('Clear Cache'),
            ),
            Container(
              color: AppColors.lightgrey1,
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Media download',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return StorageBottomSheet(
                          title: 'Download over mobile data ');
                    });
              },
              title: Text('Mobile data'),
              subtitle: Text(
                'Download over mobile data',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return StorageBottomSheet(title: 'Download over wi-fi');
                    });
              },
              title: Text('Wi-Fi'),
              subtitle: Text(
                'Download over wi-fi',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return StorageBottomSheet(title: 'Download over roaming');
                    });
              },
              title: Text('Roaming'),
              subtitle: Text(
                'Download over roaming',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
