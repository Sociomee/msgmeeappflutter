import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/data/repository/socket/msgmee_socket.dart';
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
        MsgmeeSocket().sendLoginEvent(result!.code!);
        controller.pauseCamera();
        if (scanData.toString().isNotEmpty) {
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
