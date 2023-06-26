import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../widgets/common_groups.dart';
import '../../../../theme/colors.dart';
import 'media_tab.dart';
import '../widgets/options_button_widget.dart';
import '../widgets/profile_bottom_sheet.dart';
import '../../../c_social_chat/presentation/pages/media_doc_screen/media_and_doc_screen.dart';

class OtherPersonProfileDescription extends StatelessWidget {
  const OtherPersonProfileDescription(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.isOnline});
  final String imageUrl;
  final String name;
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
            leadingWidth: 40,
            titleSpacing: 5,
            title: Text(
              name,
              style: TextStyle(color: AppColors.black, fontSize: 15),
            ),
            actions: [
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
                          return ProfileBottomModelSheet();
                        });
                  },
                  icon: Icon(Icons.more_vert, color: AppColors.black))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundColor: AppColors.grey,
                          backgroundImage: NetworkImage(imageUrl)),
                      SizedBox(height: 10),
                      isOnline
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(width: 5),
                                Text('online',
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(width: 5),
                                Text('offline',
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ],
                            ),
                      SizedBox(height: 10),
                      Text('Henna Akhtar', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 6),
                      Text('+91 819-745-8750', style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Center(child: OptionsButtomWidgets()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(Icons.description_outlined),
                      SizedBox(width: 5),
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        'Norem ipsum dolor sit amet, consectetur adipiscing elit.\nNunc vulputate libero et velit.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: AppColors.grey, thickness: 3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Media, Docs, Links',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          animatedScreenNavigator(
                              context,
                              MediaAndDocScreen(
                                profilename: name,
                              ));
                        },
                        child: Text(
                          '248',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 15)
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                  child: Text('Recent media'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 103,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 103,
                            width: 103,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: AppColors.grey, thickness: 3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CommonGroupsWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
