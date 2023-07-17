import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_textField.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../../data/model/chat_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../cubit/add_message/add_message_cubit.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.names != null}" '/' "${widget.names}");
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text(widget.pftname.split('/').first,
              style: TextStyle(
                color: AppColors.black,
              ))),
      body: widget.pftname.isNotEmpty && widget.names == null
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 220.h),
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
                      child: Center(
                        child: Text(
                          widget.pftname.split('/').first,
                          style:
                              TextStyle(color: AppColors.black, fontSize: 20),
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
                              child: SizedBox(
                            height: 40,
                            child: MessageTextFieldWidget(
                              messageController: messageController,
                              color: AppColors.white,
                              onChanged: (e) {},
                            ),
                          )),
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
                    SizedBox(height: 28)
                  ],
                ),
              ),
            )
          : widget.names != null
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
                      children: [
                        SizedBox(
                          height: 365,
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
                                      Text(
                                        widget.names![index],
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 20),
                                      ),
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
                                  child: SizedBox(
                                height: 40,
                                child: MessageTextFieldWidget(
                                  messageController: messageController,
                                  color: AppColors.white,
                                  onChanged: (e) {},
                                ),
                              )),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
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
                                                      color: Color(0xFF368C4E),
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 35.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    for (var i = 0;
                                                        i <
                                                            widget
                                                                .names!.length;
                                                        i++) {
                                                      context
                                                          .read<
                                                              AddMessageCubit>()
                                                          .addMessage(
                                                              ChatMessage(
                                                            messageContent: '',
                                                            messageType:
                                                                'sender',
                                                            msgStatus: 'send',
                                                            time:
                                                                getCurrentTime(),
                                                            type:
                                                                MessageType.doc,
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
                                                      color: Color(0xFF368C4E),
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
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Image.asset('assets/attach.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 28)
                      ],
                    ),
                  ),
                )
              : Container(),
    );
  }
}
