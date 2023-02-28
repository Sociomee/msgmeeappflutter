import 'package:flutter/material.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/attached_icons.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/chat_screen_bottom_modelsheet.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/presentation/msgmee_screen/chat_screen/widgets/sender_widget.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../data/model/chat_model.dart';
import '../../../theme/custom_theme.dart';
import '../widget/chat_profile_widget.dart';
import 'widgets/animated_attachment_icons.dart';
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
  void _scrollToBottom() {
    _listViewController.animateTo(_listViewController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
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
        title: Row(
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
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text(widget.isOnline ? 'Active Now' : '',
                    style: TextStyle(fontSize: 13, color: CustomTheme.grey)),
              ],
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/video.png',
            width: 16,
          ),
          SizedBox(
            width: 28,
          ),
          Image.asset(
            'assets/call.png',
            width: 16,
          ),
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
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: messages[index].messageType == "receiver"
                      ? SwipeTo(
                          onRightSwipe: () {
                            print('ekjne');
                          },
                          child: ReceivedMessageWidget(
                              message: messages[index].messageContent,
                              msgStatus: messages[index].msgStatus,
                              time: messages[index].time),
                        )
                      : SentMessageWidget(
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
                                        messageContent: messageController.text,
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
                                        size: 20, color: CustomTheme.iconColor),
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
    );
  }
}
