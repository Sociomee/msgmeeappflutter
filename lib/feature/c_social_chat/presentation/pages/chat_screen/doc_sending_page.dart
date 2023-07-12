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
  const DocSendingPage({super.key, required this.pftname});
  final String pftname;
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
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text(widget.pftname.split('/').first,
              style: TextStyle(color: AppColors.black))),
      body: Container(
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
              SizedBox(height: 220.h),
              SvgPicture.asset('assets/docx.svg'),
              SizedBox(height: 5),
              Text(
                widget.pftname.split('/').first,
                style: TextStyle(color: AppColors.black, fontSize: 20),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0),
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
                        context.read<AddMessageCubit>().addMessage(ChatMessage(
                              messageContent: messageController.text,
                              messageType: 'sender',
                              msgStatus: 'send',
                              time: getCurrentTime(),
                              type: MessageType.doc,
                              docName: widget.pftname,
                            ));
                        Navigator.pop(context);
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
      ),
    );
  }
}
