import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:msgmee/common_cubits/connectivity_cubit.dart';
import 'package:msgmee/common_widgets/mx_chatappbar.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/reply_msg/reply_msg_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/multiple_image_perview_page.dart';
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
import 'package:msgmee/helper/string_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../data/api_data_source/repository/chat/chat_repository.dart';
import '../../../../../data/api_data_source/repository/socket/msgmee_socket.dart';
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
import 'image_preview_page.dart';
import 'widgets/message_textField.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.senderId,
    this.hasStory,
    this.group,
    required this.lastOnline,
    this.id,
  });
  final String name;
  final String imageUrl;
  final String senderId;
  final String lastOnline;
  final bool? hasStory;
  final bool? group;
  final String? id;

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
  MsgmeeSocket msgmeeSocket = MsgmeeSocket();
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
        animatedScreenNavigator(context,
            ImagePreViewPage(images: [image], profileImage: widget.imageUrl));
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
        ChatRepostory()
            .sendImage(filename: photo.name, imageFile: File(photo.path));
        // animatedScreenNavigator(context,
        //     ImagePreViewPage(images: [photo], profileImage: widget.imageUrl));
      }
    }
  }

  @override
  void initState() {
    context.read<ChatRoomsCubit>().getPhoneAndUserid();
    context
        .read<SetChatbgCubit>()
        .chooseType(context.read<SetChatbgCubit>().state.bgType);
    context.read<ChatRoomsCubit>().getLocalDBMessagesById(widget.id ?? '');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var msg = context.read<AddMessageCubit>().state.messages;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM, y').format(now);
    var authorId = context.read<ChatRoomsCubit>().state.userId;

    var online = context.read<ChatRoomsCubit>().state.onlineUsers.where((e) {
      return e['id'] == widget.senderId;
    }).toList();
    log('calling ...');
    return WillPopScope(
        onWillPop: () async {
          context.read<SearchModeCubit>().closeMsgSearchMode();
          context.read<ShowAttachment>().closeAttachment();
          context.read<ShowEmojiCubit>().removeEmoji();
          return true;
        },
        child: BlocConsumer<ChatRoomsCubit, ChatRoomsState>(
          listener: (context, state) {
            if (state.localmessage.isNotEmpty) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _scrollToBottom());
            }
          },
          builder: (context, state) {
            log('imageurl  ${widget.imageUrl}');
            return MediaQuery(
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
                          title: Text(chattileIndex.length.toString(),
                              style: TextStyle(color: AppColors.black)),
                          actions: [
                            GestureDetector(
                                onTap: () {
                                  context.read<ReplyMsgCubit>().replyMsg(
                                      widget.name,
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
                                child: SvgPicture.asset('assets/trash.svg',
                                    height: 18)),
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
                                  Clipboard.setData(
                                      ClipboardData(text: copiedText));

                                  setState(() {
                                    chattileIndex.clear();
                                  });
                                },
                                child: SvgPicture.asset('assets/copy.svg',
                                    height: 18)),
                            SizedBox(width: 19),
                            GestureDetector(
                              onTap: () {
                                animatedScreenNavigator(
                                    context, ForwardMessagePage());
                              },
                              child: SvgPicture.asset(
                                'assets/reply.svg',
                                height: 18,
                              ),
                            ),
                            SizedBox(width: 19),
                          ],
                        )
                      : context.watch<SearchModeCubit>().state.msgSearchMode
                          ? AppBar(
                              toolbarHeight: 70,
                              elevation: 1,
                              leadingWidth: 30,
                              titleSpacing: 0,
                              leading: InkWell(
                                onTap: () {
                                  context
                                      .read<SearchModeCubit>()
                                      .changemsgSearchMode();
                                  context
                                      .read<ShowAttachment>()
                                      .closeAttachment();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 0, bottom: 8),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 180.w,
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
                                                color: Color(0XFF255D3A),
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0XFF255D3A),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0XFF255D3A),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 17.0,
                                      bottom: 10,
                                    ),
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
                                            decoration:
                                                TextDecoration.underline,
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
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.black,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: AppColors.black,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Text(
                                    '10/12',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: SelectDuration(),
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.w, bottom: 10),
                                    child: SvgPicture.asset(
                                      'assets/calender.svg',
                                    ),
                                  ),
                                )
                              ],
                            )
                          : MxChatAppBar(
                              elevation: 1,
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  context
                                      .read<ShowAttachment>()
                                      .closeAttachment();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ShowAttachment>()
                                      .closeAttachment();
                                  screenNavigator(
                                    context,
                                    OtherPersonProfileDescription(
                                      imageUrl: widget.imageUrl,
                                      name: widget.name,
                                      isOnline: online.isNotEmpty
                                          ? online.first['status']
                                          : 'Offline',
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Hero(
                                      tag: widget.imageUrl,
                                      child: widget.imageUrl ==
                                              'https://sociomee-dev.s3.ap-south-1.amazonaws.com/null'
                                          ? DefaultProfileImage(
                                              isOnline: online.isNotEmpty
                                                  ? online.first['status']
                                                  : 'Offline',
                                              hasStory: true,
                                            )
                                          : ChatProfileWidget(
                                              imageUrl: widget.imageUrl,
                                              isOnline: online.isNotEmpty
                                                  ? online.first['status']
                                                  : 'Offline',
                                              hasStory: true,
                                            ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 130.w,
                                          child: Text(
                                            widget.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          online.isNotEmpty
                                              ? online.first['status']
                                              : 'Last Online ${widget.lastOnline}',
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
                                SvgPicture.asset('assets/video.svg'),
                                SizedBox(width: 25.w),
                                SvgPicture.asset('assets/calling.svg'),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ShowAttachment>()
                                        .closeAttachment();
                                  },
                                  child: SinglechatPopupMenu(
                                    name: widget.name,
                                    imageUrl: widget.imageUrl,
                                  ),
                                )
                              ],
                            ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ChatRoomsCubit>()
                          .getchatRoomMessages(id: widget.id!);
                      context
                          .read<ChatRoomsCubit>()
                          .getLocalDBMessagesById(widget.id!);
                    },
                    child: Stack(
                      children: [
                        context.watch<SetChatbgCubit>().state.bgType ==
                                ChatBgType.solidColor
                            ? Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: context
                                    .read<SetChatbgCubit>()
                                    .state
                                    .bgContent,
                              )
                            : context.watch<SetChatbgCubit>().state.bgType ==
                                    ChatBgType.networkImage
                                ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      context
                                          .watch<SetChatbgCubit>()
                                          .state
                                          .bgContent,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : context
                                            .watch<SetChatbgCubit>()
                                            .state
                                            .bgType ==
                                        ChatBgType.fileImage
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                        if (state.localmessage.length != 0)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context.read<ShowAttachment>().closeAttachment();
                            },
                            child: ListView.builder(
                              controller: _listViewController,
                              itemCount: state.localmessage.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 100),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Align(
                                  alignment: (authorId !=
                                          state.localmessage[index].author
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: authorId !=
                                          state.localmessage[index].author
                                      ? SwipeTo(
                                          onRightSwipe: () {
                                            context
                                                .read<ReplyMsgCubit>()
                                                .replyMsg(
                                                    widget.name,
                                                    state.localmessage[index]
                                                        .content);
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
                                              if (!chattileIndex
                                                  .contains(index)) {
                                                setState(() {
                                                  chattileIndex.add(index);
                                                  copiedText =
                                                      msg[index].messageContent;
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
                                              color: chattileIndex
                                                      .contains(index)
                                                  ? AppColors.seconderyColor1
                                                  : Colors.transparent,
                                              child: Stack(
                                                children: [
                                                  ReceivedMessageWidget(
                                                    message: state
                                                        .localmessage[index]
                                                        .content,
                                                    msgStatus: state
                                                        .localmessage[index]
                                                        .status,
                                                    time: state
                                                        .localmessage[index]
                                                        .date
                                                        .iso8601To12HourFormat(),
                                                    type: state
                                                        .localmessage[index]
                                                        .type,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ShowEmojiCubit>()
                                                            .removeEmoji();
                                                      },
                                                      child: AnimatedScale(
                                                        duration: Duration(
                                                            milliseconds: 200),
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 10,
                                                            vertical: 8,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              color: Color(
                                                                  0xFF333333)),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  '🤣 ✌️ 👋 ❤️ 😥 👍 '),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: AppColors
                                                                        .lightgrey1),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 15,
                                                                ),
                                                              )
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
                                            context
                                                .read<ReplyMsgCubit>()
                                                .replyMsg(
                                                    'You',
                                                    state.localmessage[index]
                                                        .content);
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              if (chattileIndex
                                                  .contains(index)) {
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
                                              msg[index].type ==
                                                      MessageType.multipleImage
                                                  ? screenNavigator(
                                                      context,
                                                      MultipleImagePreviewPage(
                                                        name: widget.name,
                                                        images:
                                                            msg[index].images,
                                                        date: formattedDate,
                                                        time: msg[index].time,
                                                      ))
                                                  : null;
                                            },
                                            onLongPress: () async {
                                              if (!chattileIndex
                                                  .contains(index)) {
                                                setState(() {
                                                  chattileIndex.add(index);
                                                  copiedText =
                                                      msg[index].messageContent;
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
                                              color: chattileIndex
                                                      .contains(index)
                                                  ? AppColors.seconderyColor1
                                                  : Colors.transparent,
                                              child: Stack(
                                                children: [
                                                  SentMessageWidget(
                                                    // doc: msg[index].docName,
                                                    message: state
                                                        .localmessage[index]
                                                        .content,
                                                    msgStatus: state
                                                        .localmessage[index]
                                                        .status,
                                                    time: state
                                                        .localmessage[index]
                                                        .date
                                                        .iso8601To12HourFormat(),
                                                    type: state
                                                                .localmessage[
                                                                    index]
                                                                .type ==
                                                            'text'
                                                        ? MessageType.text
                                                        : MessageType.none,
                                                    // image: msg[index].image_url,
                                                    // images: msg[index].images,
                                                    // numberofContact:
                                                    // msg[index].numberofContact,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ShowEmojiCubit>()
                                                            .removeEmoji();
                                                      },
                                                      child: AnimatedScale(
                                                        duration: Duration(
                                                            milliseconds: 200),
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 10,
                                                            vertical: 8,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              color: Color(
                                                                  0xFF333333)),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  '🤣 ✌️ 👋 ❤️ 😥 👍 '),
                                                              Container(
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                          5),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: AppColors
                                                                          .lightgrey1),
                                                                  child: Icon(
                                                                      Icons.add,
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
                                  Divider(
                                    height: 0,
                                    color: AppColors.grey,
                                    thickness: 1,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                      top: 10,
                                      right: 10,
                                    ),
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
                                                    BorderRadius.circular(
                                                  30,
                                                ),
                                              ),
                                              child: Transform.rotate(
                                                angle: -15,
                                                child: Icon(
                                                  Icons.attach_file_outlined,
                                                  size: 19,
                                                  color: context
                                                          .watch<
                                                              ShowAttachment>()
                                                          .state
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                ),
                                              ),
                                            )),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () {
                                            pickCameraPic();
                                            context
                                                .read<ShowAttachment>()
                                                .closeAttachment();
                                            context
                                                .read<ShowAttachment>()
                                                .closeAttachment();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: AppColors.lightgrey1,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Icon(
                                              Icons.photo_camera_outlined,
                                              size: 20,
                                              color: AppColors.iconColor,
                                            ),
                                          ),
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
                                            var room =
                                                state.messages.room!.toJson();
                                            //* calling typing function
                                            context
                                                .read<ChatRoomsCubit>()
                                                .typing(
                                                    typing: istyping,
                                                    room: room);
                                          },
                                        )),
                                        SizedBox(width: 10),
                                        context.watch<ShowAudioRecorder>().state
                                            ? Container(width: 30)
                                            : istyping ||
                                                    context
                                                        .watch<
                                                            ShowContactTextField>()
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
                                                                .read<
                                                                    AddMessageCubit>()
                                                                .addMessage(
                                                                  ChatMessage(
                                                                    messageContent:
                                                                        messageController
                                                                            .text,
                                                                    messageType:
                                                                        'sender',
                                                                    msgStatus:
                                                                        'send',
                                                                    time:
                                                                        getCurrentTime(),
                                                                    type: MessageType
                                                                        .contact,
                                                                  ),
                                                                )
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
                                                                            messageController.text,
                                                                        messageType:
                                                                            'sender',
                                                                        msgStatus:
                                                                            'send',
                                                                        time:
                                                                            getCurrentTime(),
                                                                        type: MessageType
                                                                            .replyMessage,
                                                                      ),
                                                                    )
                                                                : context
                                                                    .read<
                                                                        AddMessageCubit>()
                                                                    .addMessage(
                                                                      ChatMessage(
                                                                        messageContent:
                                                                            messageController.text,
                                                                        messageType:
                                                                            'sender',
                                                                        msgStatus:
                                                                            'send',
                                                                        time:
                                                                            getCurrentTime(),
                                                                        type: MessageType
                                                                            .text,
                                                                      ),
                                                                    );
                                                        //* sending message function
                                                        context
                                                            .read<
                                                                ChatRoomsCubit>()
                                                            .sendMsg(
                                                              authorId: state
                                                                      .userId ??
                                                                  '',
                                                              roomId:
                                                                  widget.id ??
                                                                      '',
                                                              content:
                                                                  messageController
                                                                      .text,
                                                              contentType:
                                                                  'text',
                                                              connectivityState:
                                                                  context
                                                                      .read<
                                                                          ConnectivityCubit>()
                                                                      .state,
                                                            );

                                                        messageController
                                                            .clear();
                                                        _scrollToBottom();
                                                        context
                                                            .read<
                                                                ShowContactTextField>()
                                                            .getinitilstate();
                                                        context
                                                            .read<
                                                                ReplyMsgCubit>()
                                                            .closeReplyMsg();
                                                      } else if (context
                                                          .read<
                                                              ShowAudioRecorder>()
                                                          .state) {
                                                        context
                                                            .read<
                                                                AddMessageCubit>()
                                                            .addMessage(
                                                                ChatMessage(
                                                              messageContent:
                                                                  '',
                                                              messageType:
                                                                  'sender',
                                                              msgStatus: 'send',
                                                              time:
                                                                  getCurrentTime(),
                                                              type: MessageType
                                                                  .audio,
                                                            ));
                                                        setState(() {});
                                                        context
                                                            .read<
                                                                ShowAudioRecorder>()
                                                            .toggleValue();
                                                        _scrollToBottom();
                                                      } else if (context
                                                          .read<ReplyMsgCubit>()
                                                          .state
                                                          .reply) {
                                                        context
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
                                                            ));
                                                        context
                                                            .read<
                                                                ReplyMsgCubit>()
                                                            .closeReplyMsg();
                                                        _scrollToBottom();
                                                      } else if (context
                                                          .read<
                                                              ShowContactTextField>()
                                                          .state) {
                                                        context
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
                                                                  .contact,
                                                            ));
                                                        context
                                                            .read<
                                                                ShowContactTextField>()
                                                            .toggleValue();
                                                        _scrollToBottom();
                                                        context
                                                            .read<
                                                                ShowAttachment>()
                                                            .closeAttachment();
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .lightgrey1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          30,
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                        'assets/attach.png',
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              ShowAudioRecorder>()
                                                          .toggleValue();
                                                      _scrollToBottom();
                                                      context
                                                          .read<
                                                              ShowAttachment>()
                                                          .closeAttachment();
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .lightgrey1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Icon(
                                                          Icons.mic_none,
                                                          size: 20,
                                                          color: AppColors
                                                              .iconColor),
                                                    ),
                                                  ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //* showing reply message textfield *//
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
                            //* showing contact sender textfield widget *//
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
                            //* showing audio recorder widget *//
                            context.watch<ShowAudioRecorder>().state
                                ? Positioned(
                                    bottom: 10,
                                    left: 86,
                                    child: AudioRecordWidget(),
                                  )
                                : Container(),
                            Positioned(
                              bottom: 60,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                height: context.watch<ShowAttachment>().state
                                    ? 44 * 6
                                    : 0,
                                width: 150,
                                child: AttachedIcon(
                                  profileImage: widget.imageUrl,
                                  name: widget.name,
                                ),
                              ),
                            ),
                            //*showing current date
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
                                child: Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
