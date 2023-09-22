import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/map_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../../../../../data/model/chat_model.dart';
import '../../../../../data/model/locations_model.dart';
import '../../../../../helper/get_currenttime.dart';
import '../../cubit/add_message/add_message_cubit.dart';

class AttachLocationPage extends StatefulWidget {
  const AttachLocationPage({super.key});

  @override
  State<AttachLocationPage> createState() => _AttachLocationPageState();
}

class _AttachLocationPageState extends State<AttachLocationPage> {
  bool expand = false;
  bool loading = false;
  bool searching = false;
  String _currentAddress = 'Locaiton not Found!';
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    setState(() {
      loading = true;
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        loading = false;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            if (searching) {
              setState(() {
                searching = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 20,
            ),
          ),
        ),
        leadingWidth: 40,
        titleSpacing: 0,
        title: searching
            ? AnimatedSlide(
                offset: Offset(0, 0),
                duration: Duration(milliseconds: 1500),
                child: Expanded(
                    child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none),
                )))
            : Text(
                'Send Location',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          searching
              ? Container()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      searching = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      color: AppColors.black,
                    ),
                  ),
                )
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                height: expand ? 472.h : 200,
                width: double.infinity,
                child: MapViewWidget(),
              ),
              Positioned(
                  left: 10,
                  bottom: 10,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          expand = !expand;
                        });
                      },
                      child: expand
                          ? Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.black.withOpacity(.5)),
                              child: Icon(Icons.fullscreen_exit_outlined,
                                  color: AppColors.white, size: 26))
                          : SvgPicture.asset('assets/expand.svg'))),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    height: 41,
                    width: 41,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.white),
                    child: Icon(Icons.my_location_outlined,
                        color: AppColors.black, size: 18),
                  ))
            ],
          ),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Share Live Location',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ShareLiveLocationPopup();
                    });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.darkgreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/share_location.svg'),
                    SizedBox(width: 5),
                    Text('Share your live location',
                        style: TextStyle(color: AppColors.white))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey.withOpacity(.4), thickness: 1),
          ),
          GestureDetector(
            onTap: () async {
              await _getCurrentPosition();
              Timer(Duration(milliseconds: 500), () {
                context.read<AddMessageCubit>().addMessage(ChatMessage(
                      messageContent: _currentAddress,
                      messageType: 'sender',
                      msgStatus: 'send',
                      time: getCurrentTime(),
                      type: MessageType.location,
                    ));

                Navigator.pop(context);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white),
                child: loading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/location.svg'),
                          SizedBox(width: 5),
                          Text(
                            'Share your current location',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
              ),
            ),
          ),
          expand
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    'Popular Nearby Locations',
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 135, 135),
                    ),
                  ),
                ),
          expand
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: locations.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                            context
                                .read<AddMessageCubit>()
                                .addMessage(ChatMessage(
                                  messageContent: locations[index].subtitle,
                                  messageType: 'sender',
                                  msgStatus: 'send',
                                  time: getCurrentTime(),
                                  type: MessageType.location,
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.white,
                                    border: Border.all(color: AppColors.black)),
                                child: Icon(Icons.location_on),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(locations[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      index == 2
                                          ? Container(
                                              height: 13.w,
                                              width: 13.w,
                                              margin: EdgeInsets.only(left: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: AppColors.errorRedColor
                                                      .withOpacity(.5)),
                                              child: Icon(
                                                  Icons.fiber_manual_record,
                                                  color:
                                                      AppColors.errorRedColor,
                                                  size: 12.r),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(locations[index].subtitle,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 135, 135, 135)))
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                )
        ]),
      ),
    );
  }
}

class ShareLiveLocationPopup extends StatefulWidget {
  const ShareLiveLocationPopup({Key? key}) : super(key: key);

  @override
  State<ShareLiveLocationPopup> createState() => _ShareLiveLocationPopupState();
}

class _ShareLiveLocationPopupState extends State<ShareLiveLocationPopup> {
  late TextEditingController controller;
  int selectedIndex = 0;
  bool emojiShowing = false;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onBackspacePressed() {
    controller
      ..text = controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    height: 190,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MapViewWidget())),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Share your live location',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                          height: 36,
                          width: 95.w,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              color: selectedIndex == 0
                                  ? AppColors.darkgreen
                                  : Color(0x3F999999),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Text('15 Min',
                              style: TextStyle(
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : AppColors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500))),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                          height: 36,
                          width: 95.w,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              color: selectedIndex == 1
                                  ? AppColors.darkgreen
                                  : Color(0x3F999999),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Text('1 Hour',
                              style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : AppColors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500))),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                          height: 36,
                          width: 95.w,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              color: selectedIndex == 2
                                  ? AppColors.darkgreen
                                  : Color(0x3F999999),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Text('2 Hour',
                              style: TextStyle(
                                  color: selectedIndex == 2
                                      ? Colors.white
                                      : AppColors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500))),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Add message",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 134, 134, 134),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: AppColors.lightgrey1,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0x3F999999),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0x3F999999),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0x3F999999),
                                )),
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
                                  child: SvgPicture.asset('assets/smiley.svg',
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddMessageCubit>().addMessage(
                              ChatMessage(
                                  messageContent: controller.text,
                                  messageType: 'sender',
                                  msgStatus: 'send',
                                  time: getCurrentTime(),
                                  type: MessageType.location));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/icons/attach.svg'),
                        // child: Image.asset('assets/attach.png'),
                      ),
                    )
                  ],
                ),
                Offstage(
                    offstage: !emojiShowing,
                    child: SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          textEditingController: controller,
                          onBackspacePressed: _onBackspacePressed,
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
        ),
      ),
    );
  }
}
