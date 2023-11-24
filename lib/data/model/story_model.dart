import 'user_model.dart';

enum MediaType { image, video }

class StoryModel {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  StoryModel({
    required this.url,
    required this.media,
    required this.duration,
    required this.user,
  });
}

final List<StoryModel> stories = [
  StoryModel(
    url:
        'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600',
    media: MediaType.image,
    duration: Duration(seconds: 10),
    user: User(),
  ),
  StoryModel(
    url:
        'https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&w=1600',
    media: MediaType.image,
    duration: Duration(seconds: 7),
    user: User(),
  ),
  StoryModel(
    url:
        'https://player.vimeo.com/external/517185989.sd.mp4?s=ab1789d73c8b93fbefa1df15dff628469f0eaa8f&profile_id=165&oauth2_token_id=57447761',
    media: MediaType.video,
    duration: Duration(seconds: 9),
    user: User(),
  ),
  StoryModel(
    url:
        'https://images.pexels.com/photos/678783/pexels-photo-678783.jpeg?auto=compress&cs=tinysrgb&w=1600',
    media: MediaType.image,
    duration: Duration(seconds: 6),
    user: User(),
  ),
];
