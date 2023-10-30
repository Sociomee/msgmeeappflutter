import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../cubit/add_message/add_message_cubit.dart';
import '../../cubit/show_attachment.dart';

class DocSendingPage extends StatefulWidget {
  const DocSendingPage({super.key, required this.pftname, this.names});
  final String pftname;
  final List<String>? names;
  @override
  State<DocSendingPage> createState() => _DocSendingPageState();
}

class _DocSendingPageState extends State<DocSendingPage> {
  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    widget.names!.clear();
    super.dispose();
  }

  bool emojiShowing = false;
  onBackspacePressed() {
    messageController
      ..text = messageController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          leadingWidth: 40,
          leading: GestureDetector(
              onTap: () {
                widget.names!.clear();
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios,
                    color: AppColors.black, size: 20),
              )),
          title: Text(widget.pftname.split('/').first,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ))),
      body: widget.pftname.isNotEmpty &&
              widget.names != null &&
              widget.names!.length == 1
          ? Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.lightgrey1, AppColors.grey])),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightgrey),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 210.h),
                    widget.pftname
                                .split('/')
                                .first
                                .split('.')
                                .last
                                .toString() ==
                            'pdf'
                        ? SvgPicture.asset('assets/docx.svg', height: 50.h)
                        : widget.pftname
                                    .split('/')
                                    .first
                                    .split('.')
                                    .last
                                    .toString() ==
                                'mp3'
                            ? SvgPicture.asset('assets/mp3.svg', height: 50.h)
                            : widget.pftname
                                        .split('/')
                                        .first
                                        .split('.')
                                        .last
                                        .toString() ==
                                    'mp4'
                                ? SvgPicture.asset('assets/mp4.svg',
                                    height: 50.h)
                                : widget.pftname
                                            .split('/')
                                            .first
                                            .split('.')
                                            .last
                                            .toString() ==
                                        'png'
                                    ? SvgPicture.asset('assets/png.svg',
                                        height: 50.h)
                                    : SvgPicture.asset('assets/jpg.svg',
                                        height: 50.h),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 65.w),
                      child: SizedBox(
                        height: 30,
                        width: 400,
                        child: Center(
                          child: Text(
                            widget.pftname.split('/').first,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: AppColors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: AppColors.primaryColor,
                              controller: messageController,
                              onTap: () {
                                context
                                    .read<ShowAttachment>()
                                    .closeAttachment();
                              },
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                fillColor: AppColors.lightgrey1,
                                filled: true,
                                hintText: "Type your message",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 125, 125, 125),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 15, right: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 2, color: AppColors.lightgrey1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 2, color: AppColors.lightgrey1)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 2, color: AppColors.lightgrey1)),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/smiley.svg',
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (e) {},
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<AddMessageCubit>()
                                  .addMessage(ChatMessage(
                                    messageContent: messageController.text,
                                    messageType: 'sender',
                                    msgStatus: 'send',
                                    time: getCurrentTime(),
                                    type: MessageType.doc,
                                    docName: widget.pftname,
                                  ));
                              Navigator.pop(context);
                              if (widget.names != null) {
                                widget.names!.clear();
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset('assets/attach.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: messageController,
                              onBackspacePressed: onBackspacePressed,
                              config: Config(
                                columns: 8,
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.SMILEYS,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                recentTabBehavior: RecentTabBehavior.RECENT,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            ))),
                  ],
                ),
              ),
            )
          : widget.names != null
              ? Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.lightgrey1, AppColors.grey])),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightgrey),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          Container(
                            height: 70.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.names!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset('assets/docx.svg'),
                                        SizedBox(height: 5),
                                        Text(widget.names![index],
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 18)),
                                        Spacer(),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    controller: messageController,
                                    onTap: () {
                                      context
                                          .read<ShowAttachment>()
                                          .closeAttachment();
                                    },
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      fillColor: AppColors.lightgrey1,
                                      filled: true,
                                      hintText: "Type your message",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 125, 125, 125),
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 15,
                                          right: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.lightgrey1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.lightgrey1)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.lightgrey1)),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            emojiShowing = !emojiShowing;
                                          });
                                        },
                                        child: SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: Center(
                                            child: SvgPicture.asset(
                                                'assets/smiley.svg',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (e) {},
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Sending ${widget.names!.length} files to Razdar Hasan ?',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(width: 35.w)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF368C4E),
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 42),
                                                  GestureDetector(
                                                    onTap: () {
                                                      for (var i = 0;
                                                          i <
                                                              widget.names!
                                                                  .length;
                                                          i++) {
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
                                                                  .doc,
                                                              docName: widget
                                                                  .names![i],
                                                            ));
                                                      }
                                                      widget.names!.clear();
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Send',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF368C4E),
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15)
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                 
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightgrey1,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Image.asset('assets/attach.png'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Offstage(
                              offstage: !emojiShowing,
                              child: SizedBox(
                                  height: 250,
                                  child: EmojiPicker(
                                    textEditingController: messageController,
                                    onBackspacePressed: onBackspacePressed,
                                    config: Config(
                                      columns: 8,
                                      emojiSizeMax: 32 *
                                          (foundation.defaultTargetPlatform ==
                                                  TargetPlatform.iOS
                                              ? 1.30
                                              : 1.0),
                                      verticalSpacing: 0,
                                      horizontalSpacing: 0,
                                      gridPadding: EdgeInsets.zero,
                                      initCategory: Category.SMILEYS,
                                      bgColor: const Color(0xFFF2F2F2),
                                      indicatorColor: Colors.blue,
                                      iconColor: Colors.grey,
                                      iconColorSelected: Colors.blue,
                                      backspaceColor: Colors.blue,
                                      skinToneDialogBgColor: Colors.white,
                                      skinToneIndicatorColor: Colors.grey,
                                      enableSkinTones: true,
                                      recentTabBehavior:
                                          RecentTabBehavior.RECENT,
                                      recentsLimit: 28,
                                      replaceEmojiOnLimitExceed: false,
                                      noRecents: const Text(
                                        'No Recents',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black26),
                                        textAlign: TextAlign.center,
                                      ),
                                      loadingIndicator: const SizedBox.shrink(),
                                      tabIndicatorAnimDuration:
                                          kTabScrollDuration,
                                      categoryIcons: const CategoryIcons(),
                                      buttonMode: ButtonMode.MATERIAL,
                                      checkPlatformCompatibility: true,
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
    );
  }
}
