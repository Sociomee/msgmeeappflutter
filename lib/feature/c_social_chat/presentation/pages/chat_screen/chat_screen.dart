import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/reply_msg/reply_msg_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/audio_record_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/reply_message_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/select_duration.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/single_chat_popupmenu.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/attached_options.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/sender_widget.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/other_person_profile_description.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../../../../theme/colors.dart';
import '../../cubit/add_message/add_message_cubit.dart';
import '../../cubit/search_mode/search_mode_cubit.dart';
import '../../cubit/set_chatbg/set_chatbg_cubit.dart';
import '../../cubit/show_attachment.dart';
import '../../cubit/show_emoji/show_emoji_cubit.dart';
import '../../widgets/chat_profile_widget.dart';
import '../chat_theme/widget/chat_bg_type.dart';
import 'forward_msg_page.dart';
import 'group_chat_page.dart';
import 'image_preview_page.dart';
import 'widgets/message_textField.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.isOnline,
      required this.hasStory,
      this.marketplace});
  final String name;
  final String imageUrl;
  final bool isOnline;
  final bool hasStory;
  final bool? marketplace;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _listViewController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  bool istyping = false;
  bool tap = false;
  List chattileIndex = [];
  String copiedText = 'empty';
  void _scrollToBottom() {
    _listViewController.animateTo(_listViewController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void pickGalleryPic() async {
    // Pick an image

    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    } else if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        animatedScreenNavigator(
            context,
            ImagePreViewPage(
              images: [image],
              profileImage: widget.imageUrl,
            ));
      }
    }
  }

  void pickCameraPic() async {
    // Capture a photo
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    } else if (status.isGranted || status.isRestricted) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        animatedScreenNavigator(
            context,
            ImagePreViewPage(
              images: [photo],
              profileImage: widget.imageUrl,
            ));
      }
    }
  }

  @override
  void initState() {
    context
        .read<SetChatbgCubit>()
        .chooseType(context.read<SetChatbgCubit>().state.bgType);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var msg = context.watch<AddMessageCubit>().state.messages;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM, y').format(now);

    return WillPopScope(
      onWillPop: () async {
        context.read<SearchModeCubit>().changemsgSearchMode();
        return true;
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GestureDetector(
          onTap: () {
            context.read<ShowAttachment>().closeAttachment();
          },
          child: Scaffold(
            appBar: chattileIndex.isNotEmpty
                ? AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                    title: Text(chattileIndex.length.toString(),
                        style: TextStyle(color: AppColors.black)),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            context.read<ReplyMsgCubit>().replyMsg(widget.name,
                                msg[chattileIndex[0]].messageContent);
                            chattileIndex.clear();
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
                            chattileIndex.clear();
                          },
                          child:
                              SvgPicture.asset('assets/trash.svg', height: 18)),
                      SizedBox(width: 19),
                      Icon(Icons.error_outline_outlined,
                          color: AppColors.black, size: 16),
                      SizedBox(width: 19),
                      SvgPicture.asset('assets/note.svg', height: 18),
                      SizedBox(width: 19),
                      SvgPicture.asset('assets/pencil.svg', height: 18),
                      SizedBox(width: 19),
                      GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: copiedText));
                            //     .then((_) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text('Copied to your clipboard !')));
                            // });
                            setState(() {
                              chattileIndex.clear();
                            });
                          },
                          child:
                              SvgPicture.asset('assets/copy.svg', height: 18)),
                      SizedBox(width: 19),
                      GestureDetector(
                          onTap: () {
                            animatedScreenNavigator(
                                context, ForwardMessagePage());
                          },
                          child:
                              SvgPicture.asset('assets/reply.svg', height: 18)),
                      SizedBox(width: 19),
                    ],
                  )
                : context.watch<SearchModeCubit>().state.msgSearchMode
                    ? AppBar(
                        toolbarHeight: 70,
                        elevation: 1,
                        leadingWidth: 10,
                        titleSpacing: 0,
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<SearchModeCubit>()
                                          .changemsgSearchMode();
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                    )),
                                SizedBox(
                                    height: 40,
                                    width: 155.w,
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 0),
                                            hintText: 'Search',
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0XFF255D3A))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0XFF255D3A))),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Color(0XFF255D3A))))))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 17.0, bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Chats From:',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '14 Feb -  28 Feb',
                                    style: TextStyle(
                                      color: Color(0xFF368C4E),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        actions: [
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.black,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.black,
                              size: 30,
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: Text('10/12',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500))),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SelectDuration(),
                                      );
                                    });
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.w, bottom: 10),
                                child: SvgPicture.asset('assets/calender.svg'),
                              ))
                        ],
                      )
                    : AppBar(
                        toolbarHeight: 80,
                        elevation: 1,
                        leadingWidth: 20,
                        titleSpacing: 11.w,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,
                                color: AppColors.black)),
                        title: GestureDetector(
                          onTap: () {
                            widget.name == 'Office Group'
                                ? animatedScreenNavigator(
                                    context,
                                    GroupChatPage(
                                      imageUrl: widget.imageUrl,
                                      name: widget.name,
                                    ))
                                : screenNavigator(
                                    context,
                                    OtherPersonProfileDescription(
                                      imageUrl: widget.imageUrl,
                                      name: widget.name,
                                      isOnline: widget.isOnline,
                                    ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                  tag: widget.imageUrl,
                                  child: ChatProfileWidget(
                                      imageUrl: widget.imageUrl,
                                      isOnline: widget.isOnline,
                                      hasStory: widget.hasStory)),
                              SizedBox(width: 10.w),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130.w,
                                    child: Text(widget.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                  SizedBox(height: 8),
                                  widget.marketplace != null &&
                                          widget.marketplace!
                                      ? Text('Open now',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grey))
                                      : Container(),
                                  Text(widget.isOnline ? 'Active Now' : '',
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          SvgPicture.asset('assets/video.svg'),
                          SizedBox(width: 25.w),
                          SvgPicture.asset('assets/calling.svg'),
                          SinglechatPopupMenu(
                            name: widget.name,
                            imageUrl: widget.imageUrl,
                          ),
                        ],
                      ),
            body: Stack(
              children: [
                context.watch<SetChatbgCubit>().state.bgType ==
                        ChatBgType.solidColor
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: context.read<SetChatbgCubit>().state.bgContent)
                    : context.watch<SetChatbgCubit>().state.bgType ==
                            ChatBgType.networkImage
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              context.watch<SetChatbgCubit>().state.bgContent,
                              fit: BoxFit.cover,
                            ),
                          )
                        : context.watch<SetChatbgCubit>().state.bgType ==
                                ChatBgType.fileImage
                            ? Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Image.file(
                                  File(
                                    context
                                        .read<SetChatbgCubit>()
                                        .state
                                        .bgContent!
                                        .path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.read<ShowAttachment>().closeAttachment();
                  },
                  child: ListView.builder(
                    controller: _listViewController,
                    itemCount: msg.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: (msg[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: msg[index].messageType == "receiver"
                            ? SwipeTo(
                                onRightSwipe: () {
                                  context.read<ReplyMsgCubit>().replyMsg(
                                      widget.name, msg[index].messageContent);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      chattileIndex.remove(index);
                                    });
                                    context
                                        .read<ShowEmojiCubit>()
                                        .removeEmoji();
                                    context
                                        .read<ShowAttachment>()
                                        .closeAttachment();
                                  },
                                  onLongPress: () {
                                    if (!chattileIndex.contains(index)) {
                                      setState(() {
                                        chattileIndex.add(index);
                                        copiedText = msg[index].messageContent;
                                      });
                                      context
                                          .read<ShowEmojiCubit>()
                                          .diaplayEmoji(index);
                                    } else {
                                      setState(() {
                                        chattileIndex.remove(index);
                                      });
                                      context
                                          .read<ShowEmojiCubit>()
                                          .removeEmoji();
                                    }
                                  },
                                  child: Container(
                                    color: chattileIndex.contains(index)
                                        ? AppColors.seconderyColor1
                                        : Colors.transparent,
                                    child: Stack(
                                      children: [
                                        ReceivedMessageWidget(
                                          message: msg[index].messageContent,
                                          msgStatus: msg[index].msgStatus,
                                          time: msg[index].time,
                                          type: msg[index].messageType,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ShowEmojiCubit>()
                                                  .removeEmoji();
                                            },
                                            child: AnimatedScale(
                                              duration:
                                                  Duration(milliseconds: 200),
                                              scale: context
                                                          .watch<
                                                              ShowEmojiCubit>()
                                                          .state
                                                          .showEmoji &&
                                                      context
                                                              .watch<
                                                                  ShowEmojiCubit>()
                                                              .state
                                                              .index ==
                                                          index
                                                  ? 1
                                                  : 0,
                                              child: Container(
                                                width: context
                                                            .watch<
                                                                ShowEmojiCubit>()
                                                            .state
                                                            .showEmoji &&
                                                        context
                                                                .watch<
                                                                    ShowEmojiCubit>()
                                                                .state
                                                                .index ==
                                                            index
                                                    ? 175
                                                    : 0,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Color(0xFF333333)),
                                                child: Row(
                                                  children: [
                                                    Text('🤣 ✌️ 👋 ❤️ 😥 👍 '),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: AppColors
                                                                .lightgrey1),
                                                        child: Icon(Icons.add,
                                                            size: 15))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SwipeTo(
                                onRightSwipe: () {
                                  context.read<ReplyMsgCubit>().replyMsg(
                                      'You', msg[index].messageContent);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (chattileIndex.contains(index)) {
                                      setState(() {
                                        chattileIndex.remove(index);
                                      });
                                      context
                                          .read<ShowEmojiCubit>()
                                          .removeEmoji();
                                    }
                                    context
                                        .read<ShowAttachment>()
                                        .closeAttachment();
                                  },
                                  onLongPress: () async {
                                    if (!chattileIndex.contains(index)) {
                                      setState(() {
                                        chattileIndex.add(index);
                                        copiedText = msg[index].messageContent;
                                      });
                                      context
                                          .read<ShowEmojiCubit>()
                                          .diaplayEmoji(index);
                                    } else {
                                      setState(() {
                                        chattileIndex.remove(index);
                                      });
                                      context
                                          .read<ShowEmojiCubit>()
                                          .removeEmoji();
                                    }
                                  },
                                  child: Container(
                                    color: chattileIndex.contains(index)
                                        ? AppColors.seconderyColor1
                                        : Colors.transparent,
                                    child: Stack(
                                      children: [
                                        SentMessageWidget(
                                          doc: msg[index].docName,
                                          message: msg[index].messageContent,
                                          msgStatus: msg[index].msgStatus,
                                          time: msg[index].time,
                                          type: msg[index].type,
                                          image: msg[index].image_url,
                                          images: msg[index].images,
                                          numberofContact:
                                              msg[index].numberofContact,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ShowEmojiCubit>()
                                                  .removeEmoji();
                                            },
                                            child: AnimatedScale(
                                              duration:
                                                  Duration(milliseconds: 200),
                                              scale: context
                                                          .watch<
                                                              ShowEmojiCubit>()
                                                          .state
                                                          .showEmoji &&
                                                      context
                                                              .watch<
                                                                  ShowEmojiCubit>()
                                                              .state
                                                              .index ==
                                                          index
                                                  ? 1
                                                  : 0,
                                              child: Container(
                                                width: context
                                                            .watch<
                                                                ShowEmojiCubit>()
                                                            .state
                                                            .showEmoji &&
                                                        context
                                                                .watch<
                                                                    ShowEmojiCubit>()
                                                                .state
                                                                .index ==
                                                            index
                                                    ? 175
                                                    : 0,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Color(0xFF333333)),
                                                child: Row(
                                                  children: [
                                                    Text('🤣 ✌️ 👋 ❤️ 😥 👍 '),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: AppColors
                                                                .lightgrey1),
                                                        child: Icon(Icons.add,
                                                            size: 15))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
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
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ShowAttachment>()
                                          .toggleValue();
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: context
                                                    .watch<ShowAttachment>()
                                                    .state
                                                ? AppColors.primaryDarkColor
                                                : AppColors.lightgrey1,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Transform.rotate(
                                            angle: -15,
                                            child: Icon(
                                                Icons.attach_file_outlined,
                                                size: 19,
                                                color: context
                                                        .watch<ShowAttachment>()
                                                        .state
                                                    ? AppColors.white
                                                    : AppColors.black)))),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    pickCameraPic();
                                    context
                                        .read<ShowAttachment>()
                                        .closeAttachment();
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightgrey1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(Icons.photo_camera_outlined,
                                          size: 20,
                                          color: AppColors.iconColor)),
                                ),
                                SizedBox(width: 10),
                                Expanded(
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
                                )),
                                SizedBox(width: 10),
                                context.watch<ShowAudioRecorder>().state
                                    ? Container(width: 30)
                                    : istyping ||
                                            context
                                                .watch<ShowContactTextField>()
                                                .state
                                        ? GestureDetector(
                                            onTap: () {
                                              if (messageController
                                                  .text.isNotEmpty) {
                                                context
                                                        .read<
                                                            ShowContactTextField>()
                                                        .state
                                                    ? context
                                                        .read<AddMessageCubit>()
                                                        .addMessage(ChatMessage(
                                                          messageContent:
                                                              messageController
                                                                  .text,
                                                          messageType: 'sender',
                                                          msgStatus: 'send',
                                                          time:
                                                              getCurrentTime(),
                                                          type: MessageType
                                                              .contact,
                                                        ))
                                                    : context
                                                            .read<
                                                                ReplyMsgCubit>()
                                                            .state
                                                            .reply
                                                        ? context
                                                            .read<
                                                                AddMessageCubit>()
                                                            .addMessage(
                                                                ChatMessage(
                                                              messageContent:
                                                                  messageController
                                                                      .text,
                                                              messageType:
                                                                  'sender',
                                                              msgStatus: 'send',
                                                              time:
                                                                  getCurrentTime(),
                                                              type: MessageType
                                                                  .replyMessage,
                                                            ))
                                                        : context
                                                            .read<
                                                                AddMessageCubit>()
                                                            .addMessage(
                                                                ChatMessage(
                                                              messageContent:
                                                                  messageController
                                                                      .text,
                                                              messageType:
                                                                  'sender',
                                                              msgStatus: 'send',
                                                              time:
                                                                  getCurrentTime(),
                                                              type: MessageType
                                                                  .text,
                                                            ));
                                                messageController.clear();
                                                _scrollToBottom();
                                                context
                                                    .read<
                                                        ShowContactTextField>()
                                                    .getinitilstate();
                                                context
                                                    .read<ReplyMsgCubit>()
                                                    .closeReplyMsg();
                                              } else if (context
                                                  .read<ShowAudioRecorder>()
                                                  .state) {
                                                context
                                                    .read<AddMessageCubit>()
                                                    .addMessage(ChatMessage(
                                                      messageContent: '',
                                                      messageType: 'sender',
                                                      msgStatus: 'send',
                                                      time: getCurrentTime(),
                                                      type: MessageType.audio,
                                                    ));
                                                setState(() {});
                                                context
                                                    .read<ShowAudioRecorder>()
                                                    .toggleValue();
                                                _scrollToBottom();
                                              } else if (context
                                                  .read<ReplyMsgCubit>()
                                                  .state
                                                  .reply) {
                                                context
                                                    .read<AddMessageCubit>()
                                                    .addMessage(ChatMessage(
                                                      messageContent:
                                                          messageController
                                                              .text,
                                                      messageType: 'sender',
                                                      msgStatus: 'send',
                                                      time: getCurrentTime(),
                                                      type: MessageType
                                                          .replyMessage,
                                                    ));
                                                context
                                                    .read<ReplyMsgCubit>()
                                                    .closeReplyMsg();
                                                _scrollToBottom();
                                              } else if (context
                                                  .read<ShowContactTextField>()
                                                  .state) {
                                                context
                                                    .read<AddMessageCubit>()
                                                    .addMessage(ChatMessage(
                                                      messageContent:
                                                          messageController
                                                              .text,
                                                      messageType: 'sender',
                                                      msgStatus: 'send',
                                                      time: getCurrentTime(),
                                                      type: MessageType.contact,
                                                    ));
                                                context
                                                    .read<
                                                        ShowContactTextField>()
                                                    .toggleValue();
                                                _scrollToBottom();
                                              }
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: AppColors.lightgrey1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                    'assets/attach.png')),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ShowAudioRecorder>()
                                                  .toggleValue();
                                              _scrollToBottom();
                                            },
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
                    //?showing reply message textfield
                    context.watch<ReplyMsgCubit>().state.reply
                        ? Positioned(
                            bottom: 10,
                            left: 40.w,
                            child: ReplyMessageTextField(
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
                    //?showing contact sender textfield widget
                    context.watch<ShowContactTextField>().state
                        ? Positioned(
                            bottom: 10,
                            left: 40.w,
                            child: ContactMessageFieldWidget(
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

                    //?showing audio recorder widget
                    context.watch<ShowAudioRecorder>().state
                        ? Positioned(
                            bottom: 10, left: 86, child: AudioRecordWidget())
                        : Container(),
                    Positioned(
                        bottom: 60,
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: context.watch<ShowAttachment>().state
                                ? 44 * 6
                                : 0,
                            width: 150,
                            child:
                                AttachedIcon(profileImage: widget.imageUrl))),

                    //?showing current date
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11.74, vertical: 6.52),
                            decoration: ShapeDecoration(
                              color: Color(0xFFF3FFE9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.91),
                              ),
                            ),
                            child: Text(formattedDate,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ))))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
