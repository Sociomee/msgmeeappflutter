import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/map_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';

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

  String? _currentAddress;
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
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
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
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Send Location',
          style: TextStyle(color: AppColors.black),
        ),
        actions: [
          Icon(
            Icons.search,
            color: AppColors.black,
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
                      child: SvgPicture.asset('assets/expand.svg')))
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Share Live Location',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                context.read<AddMessageCubit>().addMessage(ChatMessage(
                      messageContent: '',
                      messageType: 'sender',
                      msgStatus: 'send',
                      time: getCurrentTime(),
                      type: MessageType.location,
                    ));
                Navigator.pop(context);
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
                    Text(
                      'Share your live location',
                      style: TextStyle(color: AppColors.white),
                    )
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
              _getCurrentPosition();
              if (_currentAddress != null) {
                context.read<AddMessageCubit>().addMessage(ChatMessage(
                      messageContent: _currentAddress!,
                      messageType: 'sender',
                      msgStatus: 'send',
                      time: getCurrentTime(),
                      type: MessageType.location,
                    ));
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.my_location_outlined,
                      color: Colors.blue,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Share your current location',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
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
                  child: Text('Popular Nearby Locations'),
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
                        return Row(
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
                                    Text(
                                      locations[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    index == 2
                                        ? Container(
                                            height: 13.w,
                                            width: 13.w,
                                            margin: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppColors.errorRedColor
                                                    .withOpacity(.5)),
                                            child: Icon(
                                              Icons.fiber_manual_record,
                                              color: AppColors.errorRedColor,
                                              size: 12.r,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(locations[index].subtitle),
                              ],
                            )
                          ],
                        );
                      }),
                )
        ]),
      ),
    );
  }
}
