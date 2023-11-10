import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/broadcast_screen/widget/popup_menu.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/broadcast_screen/broad_cast_desc_screen.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../../../../theme/colors.dart';
import '../../cubit/add_message/add_message_cubit.dart';
import '../../cubit/show_attachment.dart';
import '../../cubit/show_emoji/show_emoji_cubit.dart';
import '../chat_screen/forward_msg_page.dart';
import '../chat_screen/widgets/attached_options.dart';
import '../chat_screen/widgets/message_textField.dart';
import 'widget/broadcast_send_message.dart';

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
  String copiedText = 'empty';
  bool selectMode = false;
  List<int> selectedindex = [];
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
        appBar: selectedindex.isNotEmpty
            ? AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<ShowAttachment>().closeAttachment();
                    context.read<ShowEmojiCubit>().removeEmoji();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.arrow_back_ios,
                        color: AppColors.black, size: 20),
                  ),
                ),
                elevation: 1,
                leadingWidth: 30,
                titleSpacing: 5,
                title: Text(selectedindex.length.toString(),
                    style: TextStyle(color: AppColors.black)),
                actions: [
                  GestureDetector(
                      onTap: () {
                        // context.read<ReplyMsgCubit>().replyMsg(
                        //     widget.name, msg[chattileIndex[0]].messageContent);
                        selectedindex.clear();
                      },
                      child: SvgPicture.asset('assets/Forward.svg')),
                  SizedBox(width: 19),
                  GestureDetector(
                      onTap: () {
                        context
                            .read<AddMessageCubit>()
                            .removeMessage(ChatMessage(
                              messageContent: copiedText,
                              messageType: 'sender',
                              msgStatus: 'send',
                              time: getCurrentTime(),
                              type: MessageType.contact,
                            ));
                        selectedindex.clear();
                      },
                      child: SvgPicture.asset('assets/trash.svg', height: 18)),
                  SizedBox(width: 19),
                  Icon(
                    Icons.error_outline_outlined,
                    color: AppColors.black,
                    size: 16,
                  ),
                  SizedBox(width: 19),
                  SvgPicture.asset('assets/note.svg', height: 18),
                  SizedBox(width: 19),
                  SvgPicture.asset('assets/pencil.svg', height: 18),
                  SizedBox(width: 19),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: copiedText));
                      setState(() {
                        selectedindex.clear();
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/copy.svg',
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  GestureDetector(
                    onTap: () {
                      animatedScreenNavigator(context, ForwardMessagePage());
                    },
                    child: SvgPicture.asset(
                      'assets/reply.svg',
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                ],
              )
            : AppBar(
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
                  ),
                ),
                title: InkWell(
                  onTap: () {
                    animatedScreenNavigator(
                      context,
                      BroadCastDescriptionScreen(),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.seconderyColor1,
                          border:
                              Border.all(color: AppColors.white, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightgrey,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/broadcast.png',
                          height: 31,
                        ),
                      ),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alia, Abriella, Mariana,',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Broadcast',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  PopupMenuWidget(),
                ],
              ),
        body: Stack(
          children: [
            Column(
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
                        color: Color(0xFFF3FFE9),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                SizedBox(height: 10),
                ListView.builder(
                  controller: _listViewController,
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (selectMode) {
                          if (selectedindex.contains(index)) {
                            setState(() {
                              selectedindex.remove(index);
                            });
                          } else {
                            setState(() {
                              selectedindex.add(index);
                            });
                          }
                          if (selectedindex.isEmpty) {
                            setState(() {
                              selectMode = false;
                            });
                          }
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          selectMode = true;
                          selectedindex.add(index);
                        });
                      },
                      child: Container(
                        color: selectedindex.contains(index)
                            ? AppColors.seconderyColor1
                            : AppColors.white,
                        child: BoradCastSendMessage(),
                      ),
                    );
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
                            thickness: .5,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              bottom: 10,
                              top: 18,
                              right: 10,
                            ),
                            // height: 60,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                                Spacer(),
                                istyping
                                    ? GestureDetector(
                                        onTap: () {
                                          _scrollToBottom();
                                          messages.add(ChatMessage(
                                            messageContent:
                                                messageController.text,
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child:
                                              Image.asset('assets/attach.png'),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightgrey1,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Icon(Icons.mic_none,
                                              size: 20,
                                              color: AppColors.iconColor),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              left: 70.w,
              child: SizedBox(
                width: 250.w,
                child: MessageTextFieldWidget(
                  imageTextfield: false,
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
              ),
            ),
            tap
                ? Positioned(
                    bottom: 80,
                    child: SizedBox(
                        height: 220,
                        width: 150,
                        child: AttachedIcon(
                          profileImage: '',
                          name: '',
                        )))
                : Container()
          ],
        ),
      ),
    );
  }
}
