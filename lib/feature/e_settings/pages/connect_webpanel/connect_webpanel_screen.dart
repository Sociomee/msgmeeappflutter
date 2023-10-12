import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/api_data_source/repository/socket/msgmee_socket.dart';
import 'package:msgmee/helper/local_data.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../theme/colors.dart';

class ConncetWenPanelScreen extends StatefulWidget {
  const ConncetWenPanelScreen({super.key});

  @override
  State<ConncetWenPanelScreen> createState() => _ConncetWenPanelScreenState();
}

class _ConncetWenPanelScreenState extends State<ConncetWenPanelScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool scaning = true;

  @override
  void initState() {
    super.initState();
    MsgmeeSocket().connectSocket();
    MsgmeeSocket().testSocketUrl(mainbaseUrl).then((value) {
      log("test---->${value.toString()}");
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                    size: 17,
                  ),
                )),
            leadingWidth: 40,
            titleSpacing: 0,
            title: Text(
              'Scan QR',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            )),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppColors.black.withOpacity(.8)),
          child: Column(children: [
            Spacer(),
            Center(
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: QRView(
                        key: qrKey,
                        overlay: QrScannerOverlayShape(
                            borderColor: AppColors.primaryColor,
                            borderRadius: 10,
                            borderLength: 30,
                            borderWidth: 10,
                            cutOutBottomOffset: 0),
                        onQRViewCreated: _onQRViewCreated,
                        overlayMargin: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  if (scaning) QRScannerLoader()
                ],
              ),
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.only(bottom: 89, left: 30, right: 30),
                child: Text(
                  'Open web.sociomee.com, desktop app, or other devices.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ]),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (scaning) {
        scaning = false;
        log('Qrdata--->${scanData.code}');
        Map<String, dynamic> data = jsonDecode(result!.code!);
        String deviceId = data['deviceId'];
        Localdata().storedata('deviceId', deviceId);
        controller.pauseCamera();
        if (scanData.toString().isNotEmpty) {
          MsgmeeSocket().sendLoginEvent();
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}

class QRScannerLoader extends StatefulWidget {
  @override
  _QRScannerLoaderState createState() => _QRScannerLoaderState();
}

class _QRScannerLoaderState extends State<QRScannerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Adjust the duration as needed
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 300.0,
            height: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            transform: Matrix4.translationValues(
              0,
              _controller.value * 300.0,
              0,
            ),
          );
        },
      ),
    );
  }
}
