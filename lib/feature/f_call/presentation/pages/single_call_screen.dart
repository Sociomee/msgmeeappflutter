import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/feature/f_call/presentation/pages/call_screen.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../data/api_data_source/repository/chat/chat_repository.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../repos/base_repo.dart';

class SingleCallScreen extends StatelessWidget {

  SingleCallScreen({super.key, required this.imageUrl,required this.counterPartId,required this.name , required this.isOutGoing , required this.meetingId , required this.roomId, required this.isVideo});
  final String imageUrl;
  final String counterPartId;
  final String name;
  final String meetingId;
  final String roomId;
  final bool isOutGoing;
  final bool isVideo;
  @override
  Widget build(BuildContext context) {
    var currentuserId = context.read<BaseRepo>().getuserId;
    double width = MediaQuery.of(context).size.width - 86;

    if(isOutGoing){
       postCall();
    }
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.9675 - 8.5.h,
                // height: MediaQuery.of(context).size.height,
              ),
              Positioned(bottom: 0, child: Image.asset('assets/overlay.png')),
              Positioned(
                  top: 76,
                  left: width.w / 2,
                  child: Text(
                    name,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                top: 126,
                left: width.w / 2,
                child: Row(
                  children: [
                    Image.asset('assets/call_outgoing.png', height: 20),
                    SizedBox(width: 5),
                    Text(
                      'Ringing...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.r,
                      ),
                    )
                  ],
                ),
              ),
              isOutGoing ? SizedBox(): Positioned(
                  bottom: 86,
                  left: (width / 2).w - ( isOutGoing ? 0.w  : 75.w ),
                  // right: width / 2,
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      
                      acceptCall(counterPartId ,context);
                    },
                    child: Container(
                      height: 60.w,
                      width: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(209, 69, 145, 15),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.phone, color: AppColors.white),
                    ),
                  )),

                  Positioned(
                  bottom: 86,
                  //left: (width / 2).w,
                  right: (width / 2) - ( isOutGoing ? 0.w  : 75.w ),
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      
                      postCancelCall(counterPartId);
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
                  ))
            ],
          ),
        ],
      )),
    );
  }
  
  void acceptCall(String userId , BuildContext context) async{
   
    
    bool isAccepted = await ChatRepostory().postCallAccept({"userID" : counterPartId, "meetingID" : meetingId , "answer" : true});
    if(isAccepted){
        //move to call screen
        Navigator.of(context).pop();
        animatedScreenNavigator(context,CallScreen(isVideo: isVideo, meetingId : meetingId , roomId : roomId ));
    }
  }

  void postCall() async{
     bool isCallSuccess = await ChatRepostory().postNewCall(roomId , meetingId);
    if(isCallSuccess){
      print("Call success");
    }else{
      print("Call failed");
    }
  }

  void postCancelCall(userId) async{
    print(userId);
     bool isCallSuccess = await ChatRepostory().postCancelCall(userId , meetingId);
    if(isCallSuccess){
      print("Call end success");
    }else{
      print("Call end failed");
    }
  }
}
