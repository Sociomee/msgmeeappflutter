import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/connectivity/call_service.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/widgets/local_stream.dart';
import 'package:msgmee/repos/call_media_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import '../../../../connectivity/socket_service.dart';
import '../../../../connectivity/web_socket.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../repos/base_repo.dart';
import '../../../../theme/colors.dart';
import '../../widgets/VideoInputSelector.dart';
import '../../widgets/audio_output.dart';
import '../../widgets/leave.dart';
import '../../widgets/list_remote_streams.dart';
import '../../widgets/microphone.dart';
import '../../widgets/webcam.dart';

class CallScreen extends StatefulWidget {
  Room room;
  CallScreen({super.key, required this.room});
  
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var mediaRepo;
 bool show = true;

  void toggle() {
    setState(() {
      show = !show;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    // joinCall();
    super.initState();
  }

  void joinCall(){
    var currentuserId = context.read<BaseRepo>().getuserId;
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    const roomId = "659fdf9411528814d5612a99";
    print(currentuserId);
  CallService().join(currentuserId, roomId);
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        joinCall();
      }),
      
      body: ExpandableBottomSheet(
        persistentContentHeight: kToolbarHeight + 16,
        expandableContent: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: show ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.4 + 2,
              minHeight: screenHeight * 0.4 + 2,
              maxWidth: 300,
              minWidth: 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: 30,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Divider(
                      height: 2,
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Webcam(),
                      Microphone(),
                      AudioOutput(),
                      Leave(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.mic),
                                Text(
                                  'Audio Input',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                           // AudioInputSelector(),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.videocam),
                                Text(
                                  'Video Input',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                            VideoInputSelector(),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         const Icon(Icons.videocam),
                        //         Text(
                        //           'Audio Output',
                        //           style: Theme.of(context).textTheme.headline5,
                        //         ),
                        //       ],
                        //     ),
                        //     AudioOutputSelector(),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        background: GestureDetector(
          onTap: toggle,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListRemoteStreams(),
              LocalStream(),
            ],
          ),
        ),
      ),
    );
  }
}
