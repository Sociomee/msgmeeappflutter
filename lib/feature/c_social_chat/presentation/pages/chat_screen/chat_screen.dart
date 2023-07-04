import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/cubit/add_message_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_audio_recorder.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_contact_textfield.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/audio_record_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/single_chat_popupmenu.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/attached_icons.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/receiver_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/sender_widget.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/other_person_profile_description.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../theme/colors.dart';
import '../../cubit/show_attachment.dart';
import '../../widgets/chat_profile_widget.dart';
import 'group_chat_page.dart';
import 'image_preview_page.dart';
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
            image: File(image.path),
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
            image: File(photo.path),
            profileImage: widget.imageUrl,
          ));
    }
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
              widget.name == 'Office Group'
                  ? animatedScreenNavigator(
                      context,
                      GroupChatPage(
                        imageUrl: widget.imageUrl,
                        name: widget.name,
                      ))
                  : animatedScreenNavigator(
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
            SinglechatPopupMenu(name: widget.name),
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _listViewController,
              itemCount: context.read<AddMessageCubit>().state.messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 60),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                  alignment: (context
                              .read<AddMessageCubit>()
                              .state
                              .messages[index]
                              .messageType ==
                          "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: context
                              .read<AddMessageCubit>()
                              .state
                              .messages[index]
                              .messageType ==
                          "receiver"
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
                              message: context
                                  .read<AddMessageCubit>()
                                  .state
                                  .messages[index]
                                  .messageContent,
                              msgStatus: context
                                  .read<AddMessageCubit>()
                                  .state
                                  .messages[index]
                                  .msgStatus,
                              time: context
                                  .read<AddMessageCubit>()
                                  .state
                                  .messages[index]
                                  .time,
                              type: context
                                  .read<AddMessageCubit>()
                                  .state
                                  .messages[index]
                                  .messageType,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              // chattileIndex
                              //     .remove(messages[index].messageContent);
                            });
                          },
                          onLongPress: () async {
                            setState(() {
                              chattileIndex.add(messages[index].messageContent);
                            });
                          },
                          child: SentMessageWidget(
                            message: context
                                .watch<AddMessageCubit>()
                                .state
                                .messages[index]
                                .messageContent,
                            msgStatus: context
                                .watch<AddMessageCubit>()
                                .state
                                .messages[index]
                                .msgStatus,
                            time: context
                                .watch<AddMessageCubit>()
                                .state
                                .messages[index]
                                .time,
                            type: context
                                .watch<AddMessageCubit>()
                                .state
                                .messages[index]
                                .type,
                            image: context
                                .watch<AddMessageCubit>()
                                .state
                                .messages[index]
                                .image_url,
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
                                                  time: '4:28 pm',
                                                  type: MessageType.contact,
                                                ))
                                            : context
                                                .read<AddMessageCubit>()
                                                .addMessage(ChatMessage(
                                                  messageContent:
                                                      messageController.text,
                                                  messageType: 'sender',
                                                  msgStatus: 'send',
                                                  time: '4:28 pm',
                                                  type: MessageType.text,
                                                ));
                                        setState(() {});
                                        messageController.clear();
                                      } else if (context
                                          .read<ShowAudioRecorder>()
                                          .state) {
                                        context
                                            .read<AddMessageCubit>()
                                            .addMessage(ChatMessage(
                                              messageContent: '',
                                              messageType: 'sender',
                                              msgStatus: 'send',
                                              time: '4:28 pm',
                                              type: MessageType.audio,
                                            ));
                                        setState(() {});
                                        context
                                            .read<ShowAudioRecorder>()
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
                //showing contack sender textfield widget
                context.watch<ShowContactTextField>().state
                    ? Positioned(
                        bottom: 10,
                        left: 84,
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
