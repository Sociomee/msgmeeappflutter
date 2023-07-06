import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/broadcast_screen/broad_cast_desc_screen.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../theme/colors.dart';
import '../chat_screen/widgets/attached_icons.dart';
import '../chat_screen/widgets/message_textField.dart';
import '../chat_screen/widgets/sender_widget.dart';
import 'widget/broadcast_bottomsheet.dart';

class BroadCastChatScreen extends StatefulWidget {
  const BroadCastChatScreen({super.key});

  @override
  State<BroadCastChatScreen> createState() => _BroadCastChatScreenState();
}

class _BroadCastChatScreenState extends State<BroadCastChatScreen> {
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
          title: InkWell(
            onTap: () {
              animatedScreenNavigator(context, BroadCastDescriptionScreen());
            },
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.seconderyColor1,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightgrey,
                          offset: Offset(0, 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset('assets/broadcast.png', height: 31)),
                SizedBox(width: 13),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alia, Abriella, Mariana,',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text('Broadcast',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                  ],
                ),
              ],
            ),
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
                      return BroadcastBottomModelSheet(
                        profilename: 'widget.name',
                      );
                    });
              },
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.black,
              ),
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 42,
              alignment: Alignment.center,
              child: Container(
                height: 32,
                width: 69,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.seconderyColor1,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Today'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 42,
              alignment: Alignment.center,
              child: Container(
                height: 32,
                margin: EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.seconderyColor1,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'You created a broadcast list with 10 recipients',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            ListView.builder(
              controller: _listViewController,
              itemCount: 1,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          chattileIndex.remove(messages[index].messageContent);
                        });
                      },
                      onLongPress: () async {},
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 12,
                            child: SentMessageWidget(
                              doc: '',
                              message:
                                  'This is a broadcast message. Please link your SocioMee account with MsgMee account so that we can be friends in both applications',
                              msgStatus: messages[index].msgStatus,
                              time: messages[index].time,
                              type: messages[index].type,
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
            Spacer(),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 0,
                        color: AppColors.grey,
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
                                  color: AppColors.lightgrey1,
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
                                        messageContent: messageController.text,
                                        messageType: 'sender',
                                        msgStatus: 'send',
                                        time: '4:28 pm',
                                        type: MessageType.text,
                                      ));
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
                tap
                    ? Positioned(
                        bottom: 60,
                        child: SizedBox(
                            height: 200,
                            width: 150,
                            child: AttachedIcon(
                              profileImage: '',
                            )))
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
