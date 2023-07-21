import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/audio_record_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/single_chat_popupmenu.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/attached_options.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/sender_widget.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/other_person_profile_description.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../../../../theme/colors.dart';
import '../../cubit/add_message/add_message_cubit.dart';
import '../../cubit/set_chatbg/set_chatbg_cubit.dart';
import '../../cubit/show_attachment.dart';
import '../../widgets/chat_profile_widget.dart';
import '../chat_theme/widget/chat_bg_type.dart';
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
  void _scrollToBottom() {
    _listViewController.animateTo(_listViewController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void pickGalleryPic() async {
    // Pick an image
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

  void pickCameraPic() async {
    // Capture a photo
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

  @override
  void initState() {
    context
        .read<SetChatbgCubit>()
        .chooseType(context.read<SetChatbgCubit>().state.bgType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    var msg = context.read<AddMessageCubit>().state.messages;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          leadingWidth: 20,
          titleSpacing: 11.w,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
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
                      hasStory: widget.hasStory),
                ),
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
                    widget.marketplace != null && widget.marketplace!
                        ? Text('Open now',
                            style:
                                TextStyle(fontSize: 13, color: AppColors.grey))
                        : Container(),
                    Text(widget.isOnline ? 'Active Now' : '',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            SvgPicture.asset('assets/video.svg'),
            SizedBox(width: 25.w),
            SvgPicture.asset('assets/calling.svg'),
            SinglechatPopupMenu(name: widget.name),
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
            ListView.builder(
              controller: _listViewController,
              itemCount: msg.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 60),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                  alignment: (msg[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: msg[index].messageType == "receiver"
                      ? SwipeTo(
                          onRightSwipe: () {},
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
                              message: msg[index].messageContent,
                              msgStatus: msg[index].msgStatus,
                              time: msg[index].time,
                              type: msg[index].messageType,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          onLongPress: () async {
                            setState(() {
                              chattileIndex.add(messages[index].messageContent);
                            });
                          },
                          child: SentMessageWidget(
                            doc: msg[index].docName,
                            message: msg[index].messageContent,
                            msgStatus: msg[index].msgStatus,
                            time: msg[index].time,
                            type: msg[index].type,
                            image: msg[index].image_url,
                            images: msg[index].images,
                            numberofContact: msg[index].numberofContact,
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
                      Divider(height: 0, color: AppColors.grey),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, bottom: 10, top: 10, right: 10),
                        height: 60,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  context.read<ShowAttachment>().toggleValue();
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
                                        child: Icon(Icons.attach_file_outlined,
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
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightgrey1,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(Icons.photo_camera_outlined,
                                      size: 20, color: AppColors.iconColor)),
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
                            istyping ||
                                    context.watch<ShowContactTextField>().state
                                ? GestureDetector(
                                    onTap: () {
                                      if (messageController.text.isNotEmpty) {
                                        _scrollToBottom();

                                        context
                                                .read<ShowContactTextField>()
                                                .state
                                            ? context
                                                .read<AddMessageCubit>()
                                                .addMessage(ChatMessage(
                                                  messageContent:
                                                      messageController.text,
                                                  messageType: 'sender',
                                                  msgStatus: 'send',
                                                  time: getCurrentTime(),
                                                  type: MessageType.contact,
                                                ))
                                            : context
                                                .read<AddMessageCubit>()
                                                .addMessage(ChatMessage(
                                                  messageContent:
                                                      messageController.text,
                                                  messageType: 'sender',
                                                  msgStatus: 'send',
                                                  time: getCurrentTime(),
                                                  type: MessageType.text,
                                                ));

                                        messageController.clear();
                                        context
                                            .read<ShowContactTextField>()
                                            .getinitilstate();
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
                                      } else if (context
                                          .read<ShowContactTextField>()
                                          .state) {
                                        context
                                            .read<AddMessageCubit>()
                                            .addMessage(ChatMessage(
                                              messageContent:
                                                  messageController.text,
                                              messageType: 'sender',
                                              msgStatus: 'send',
                                              time: getCurrentTime(),
                                              type: MessageType.contact,
                                            ));
                                        context
                                            .read<ShowContactTextField>()
                                            .toggleValue();
                                      }
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
                                    onTap: () {
                                      context
                                          .read<ShowAudioRecorder>()
                                          .toggleValue();
                                    },
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
                //showing contack sender textfield widget
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

                //showing audio recorder widget
                context.watch<ShowAudioRecorder>().state
                    ? Positioned(
                        bottom: 10, left: 86, child: AudioRecordWidget())
                    : Container(),
                Positioned(
                    bottom: 60,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height:
                            context.watch<ShowAttachment>().state ? 44 * 6 : 0,
                        width: 150,
                        child: AttachedIcon(profileImage: widget.imageUrl)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
