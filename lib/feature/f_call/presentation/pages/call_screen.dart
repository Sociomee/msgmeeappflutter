import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/repos/call_media_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../connectivity/socket_service.dart';
import '../../../../connectivity/web_socket.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';

class CallScreen extends StatefulWidget {
  Room room;
  CallScreen({super.key, required this.room});
  
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var mediaRepo;
  @override
  void initState() {
    // TODO: implement initState
    joinCall();
    super.initState();
  }

  void joinCall(){
    mediaRepo = context.read<CallMediaCubit>();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 86;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        print("FJHFJVCDHHDCHEGFDHFHDFGLGEHSALGHJDFGDHGLGDHlA");
      }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: const Color.fromARGB(0, 244, 67, 54),
                onTap: () {
                  animatedScreenPop(context);
                },
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.errorRedColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.phone, color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [],
          ),
        ],
      )),
    );
  }
}
