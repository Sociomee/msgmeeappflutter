import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/attached_icons.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/chat_screen_bottom_modelsheet.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/sender_widget.dart';
import 'package:msgmee/presentation/profile/profile_desc/other_person_profile_description.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';
import 'widgets/message_textField.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.isOnline,
      required this.hasStory});
  final String name;
  final String imageUrl;
  final bool isOnline;
  final bool hasStory;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _listViewController = ScrollController();
  bool istyping = false;
  bool tap = false;
  List chattileIndex = [];
  void _scrollToBottom() {
    _listViewController.animateTo(_listViewController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          leadingWidth: 20,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              )),
          title: GestureDetector(
            onTap: () {
              animatedScreenNavigator(
                  context,
                  OtherPersonProfileDescription(
                    imageUrl: widget.imageUrl,
                    name: widget.name,
                    isOnline: widget.isOnline,
                  ));
            },
            child: Row(
              children: [
                ChatProfileWidget(
                    imageUrl: widget.imageUrl,
                    isOnline: widget.isOnline,
                    hasStory: widget.hasStory),
                SizedBox(width: 13),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 8),
                    Text(widget.isOnline ? 'Active Now' : '',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Image.asset('assets/video.png', width: 16),
            SizedBox(width: 28),
            Image.asset('assets/call.png', width: 16),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      context: context,
                      builder: (context) {
                        return ChatScreenBottomModelSheet(
                            profilename: widget.name);
                      });
                },
                icon: const Icon(Icons.more_vert, color: AppColors.black))
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _listViewController,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 60),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: messages[index].messageType == "receiver"
                      ? SwipeTo(
                          onRightSwipe: () {
                            print('ekjne');
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                chattileIndex
                                    .remove(messages[index].messageContent);
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                chattileIndex
                                    .add(messages[index].messageContent);
                              });
                            },
                            child: ReceivedMessageWidget(
                                message: messages[index].messageContent,
                                msgStatus: messages[index].msgStatus,
                                time: messages[index].time),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              chattileIndex
                                  .remove(messages[index].messageContent);
                            });
                          },
                          onLongPress: () async {
                            setState(() {
                              chattileIndex.add(messages[index].messageContent);
                            });
                          },
                          child: SentMessageWidget(
                              message: messages[index].messageContent,
                              msgStatus: messages[index].msgStatus,
                              time: messages[index].time),
                        ),
                );
              },
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(height: 0, color: AppColors.grey),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, bottom: 10, top: 10, right: 10),
                        height: 60,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            // SizedBox(width: 30, child: FlowAnimationWidget()),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tap = !tap;
                                  });
                                },
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: tap
                                            ? AppColors.primaryDarkColor
                                            : AppColors.lightgrey1,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Transform.rotate(
                                        angle: -15,
                                        child: Icon(Icons.attach_file_outlined,
                                            size: 19,
                                            color: tap
                                                ? AppColors.white
                                                : AppColors.black)))),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(Icons.photo_camera_outlined,
                                    size: 20, color: AppColors.iconColor),
                              ),
                            ),
                            SizedBox(width: 10),

                            Expanded(
                                child: MessageTextFieldWidget(
                              messageController: messageController,
                              onChanged: (e) {
                                if (e.isNotEmpty) {
                                  setState(() {
                                    istyping = true;
                                  });
                                } else {
                                  setState(() {
                                    istyping = false;
                                  });
                                }
                              },
                            )),
                            SizedBox(width: 10),
                            istyping
                                ? GestureDetector(
                                    onTap: () {
                                      _scrollToBottom();
                                      messages.add(ChatMessage(
                                          messageContent:
                                              messageController.text,
                                          messageType: 'sender',
                                          msgStatus: 'send',
                                          time: '4:28 pm'));
                                      setState(() {});
                                      messageController.clear();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightgrey1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Image.asset('assets/attach.png'),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightgrey1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(Icons.mic_none,
                                          size: 20, color: AppColors.iconColor),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                context.watch<ShowContactTextField>().state
                    ? Positioned(
                        bottom: 10,
                        left: 84,
                        child: MessageFieldWidget(
                          messageController: messageController,
                          onChanged: (e) {
                            if (e.isNotEmpty) {
                              setState(() {
                                istyping = true;
                              });
                            } else {
                              setState(() {
                                istyping = false;
                              });
                            }
                          },
                        ),
                      )
                    : Container(),
                Positioned(
                    bottom: 60,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: tap ? 44 * 6 : 0,
                        width: 150,
                        child: AttachedIcon()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
