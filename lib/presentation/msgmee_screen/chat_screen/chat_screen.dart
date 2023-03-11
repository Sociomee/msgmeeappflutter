import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/attached_icons.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/chat_screen_bottom_modelsheet.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/sender_widget.dart';
import 'package:msgmee/presentation/profile/profile_desc/other_person_profile_description.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../data/model/chat_model.dart';
import '../../../theme/custom_theme.dart';
import '../widget/chat_profile_widget.dart';
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
                color: CustomTheme.black,
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
                          color: CustomTheme.black,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 8),
                    Text(widget.isOnline ? 'Active Now' : '',
                        style:
                            TextStyle(fontSize: 13, color: CustomTheme.grey)),
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
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return ChatScreenBottomModelSheet(
                        profilename: widget.name,
                      );
                    });
              },
              icon: const Icon(
                Icons.more_vert,
                color: CustomTheme.black,
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _listViewController,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: messages[index].messageType == "receiver"
                        ? SwipeTo(
                            onRightSwipe: () {
                              print('ekjne');
                            },
                            child: Container(
                              color: chattileIndex
                                      .contains(messages[index].messageContent)
                                  ? CustomTheme.seconderyColor1
                                  : Colors.transparent,
                              child: ListTile(
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
                                contentPadding: EdgeInsets.zero,
                                title: ReceivedMessageWidget(
                                    message: messages[index].messageContent,
                                    msgStatus: messages[index].msgStatus,
                                    time: messages[index].time),
                              ),
                            ),
                          )
                        : Container(
                            color: chattileIndex
                                    .contains(messages[index].messageContent)
                                ? CustomTheme.seconderyColor1
                                : Colors.transparent,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  chattileIndex
                                      .remove(messages[index].messageContent);
                                });
                              },
                              onLongPress: () async {
                                setState(() {
                                  chattileIndex
                                      .add(messages[index].messageContent);
                                });
                                final selectedOption = await showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0, 0, 0, 0),
                                  items: [
                                    PopupMenuItem(
                                      child: Text('Option 1'),
                                      value: 'Option 1',
                                    ),
                                    PopupMenuItem(
                                      child: Text('Option 2'),
                                      value: 'Option 2',
                                    ),
                                    PopupMenuItem(
                                      child: Text('Option 3'),
                                      value: 'Option 3',
                                    ),
                                  ],
                                );
                                if (selectedOption == 'Option 1') {
                                  // Handle Option 1
                                } else if (selectedOption == 'Option 2') {
                                  // Handle Option 2
                                } else if (selectedOption == 'Option 3') {
                                  // Handle Option 3
                                }
                              },
                              contentPadding: EdgeInsets.zero,
                              title: SentMessageWidget(
                                  message: messages[index].messageContent,
                                  msgStatus: messages[index].msgStatus,
                                  time: messages[index].time),
                            ),
                          ),
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
                      Divider(
                        height: 0,
                        color: CustomTheme.grey,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          bottom: 10,
                          top: 10,
                          right: 10,
                        ),
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
                                  color: CustomTheme.lightgrey1,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset('assets/paper_clip.png'),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: CustomTheme.lightgrey1,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(Icons.photo_camera_outlined,
                                    size: 20, color: CustomTheme.iconColor),
                              ),
                            ),
                            SizedBox(width: 10),

                            Expanded(
                                child: ReplyMessageTextField(
                              message: 'reply message ',
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
                                        color: CustomTheme.lightgrey1,
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
                                        color: CustomTheme.lightgrey1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(Icons.mic_none,
                                          size: 20,
                                          color: CustomTheme.iconColor),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                tap
                    ? Positioned(
                        bottom: 60,
                        child: SizedBox(
                            height: 200, width: 150, child: AttachedIcon()))
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
