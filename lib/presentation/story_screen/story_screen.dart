
import 'package:flutter/material.dart';
import 'package:msgmee/presentation/story_screen/widget/story_data.dart';
import 'package:video_player/video_player.dart';
import '../../data/model/story_model.dart';
import '../../data/model/user_model.dart';
import '../../theme/colors.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animController;
  late VideoPlayerController videoController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(vsync: this);
    pageController = PageController();
    videoController = VideoPlayerController.network(stories[2].url)
      ..initialize().then((value) => setState(() {}));
    videoController.play();

    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.stop();
        animController.reset();
        setState(() {
          if (currentIndex + 1 < stories.length) {
            currentIndex += 1;
            _loadStory(story: stories[currentIndex]);
          } else {
            currentIndex = 0;
            _loadStory(story: stories[currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    animController.dispose();
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoryModel story = stories[currentIndex];
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            GestureDetector(
              onTapDown: (details) => _onTapDown(details, story),
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final StoryModel story = stories[index];
                    switch (story.media) {
                      case MediaType.image:
                        return Image.network(
                          story.url,
                          fit: BoxFit.cover,
                        );
                      // return CachedNetworkImage(
                      //   imageUrl: story.url,
                      //   fit: BoxFit.cover,
                      // );
                      case MediaType.video:
                        if (videoController.value.isInitialized) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: videoController.value.size.width,
                              height: videoController.value.size.height,
                              child: VideoPlayer(videoController),
                            ),
                          );
                        }
                    }
                    return const SizedBox.shrink();
                  }),
            ),
            Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    Row(
                      children: stories
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                                i,
                                AnimatedBar(
                                  animController: animController,
                                  position: i,
                                  currentIndex: currentIndex,
                                ));
                          })
                          .values
                          .toList(),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.5, vertical: 10),
                      child: UserInfo(user: story.user),
                    )
                  ],
                ))
          ],
        ));
  }

  void _onTapDown(TapDownDetails details, StoryModel story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (currentIndex - 1 >= 0) {
          currentIndex -= 1;
          _loadStory(story: stories[currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (currentIndex + 1 < stories.length) {
          currentIndex += 1;
          _loadStory(story: stories[currentIndex]);
        } else {
          currentIndex = 0;
          _loadStory(story: stories[currentIndex]);
        }
      });
    } else {
      if (story.media == MediaType.video) {
        if (videoController.value.isPlaying) {
          videoController.pause();
          animController.stop();
        } else {
          videoController.play();
          animController.forward();
        }
      }
    }
  }

  void _loadStory({required StoryModel story, bool animateToPage = true}) {
    animController.stop();
    animController.reset();
    switch (story.media) {
      case MediaType.image:
        animController.duration = story.duration;
        animController.forward();
        break;
      case MediaType.video:
        videoController.dispose();
        videoController = VideoPlayerController.network(story.url)
          ..initialize().then((_) {
            setState(() {});

            if (videoController.value.isInitialized) {
              animController.duration = videoController.value.duration;
              videoController.play();
              animController.forward();
            }
          });

        break;
    }
    if (animateToPage) {
      pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar(
      {super.key,
      required this.animController,
      required this.position,
      required this.currentIndex});
  final AnimationController animController;
  final int position;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            _buildContainer(
                double.infinity,
                position < currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.5)),
            position == currentIndex
                ? AnimatedBuilder(
                    animation: animController,
                    builder: (context, child) {
                      return _buildContainer(
                          constraints.maxWidth * animController.value,
                          Colors.white);
                    })
                : SizedBox.shrink()
          ],
        );
      }),
    ));
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black26,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.grey,
          backgroundImage: NetworkImage(user.imageUrl),
        ),
        SizedBox(width: 10),
        Expanded(
            child: Text(
          user.user,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            ))
      ],
    );
  }
}
