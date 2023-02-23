// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:msgmee/presentation/msgmee_screen/widget/small_profile_widget.dart';
import 'package:msgmee/theme/custom_theme.dart';

class Story {
  final String imageUrl;
  final String title;
  final bool isme;
  Story({required this.imageUrl, required this.title, this.isme = false});
}

List<Story> dummyStory = [
  Story(
      imageUrl:
          'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Your Story',
      isme: true),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/678783/pexels-photo-678783.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/3779760/pexels-photo-3779760.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/1370750/pexels-photo-1370750.jpeg?auto=compress&cs=tinysrgb&w=16000',
      title: 'Jocelyn_12'),
  Story(
      imageUrl:
          'https://images.pexels.com/photos/2076596/pexels-photo-2076596.jpeg?auto=compress&cs=tinysrgb&w=1600',
      title: 'Jocelyn_12'),
];

class SocialStoryWidget extends StatelessWidget {
  const SocialStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dummyStory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SmallProfileWidget(
                      imageUrl: dummyStory[index].imageUrl,
                      isOnline: false,
                      isMe: dummyStory[index].isme,
                      hasStory: true),
                  Title(
                      color: CustomTheme.primaryColor,
                      child: Text(dummyStory[index].title,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)))
                ],
              ),
            );
          }),
    );
  }
}
