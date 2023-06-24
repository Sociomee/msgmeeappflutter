import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../theme/colors.dart';

class ProfileScanPage extends StatefulWidget {
  const ProfileScanPage({super.key});

  @override
  State<ProfileScanPage> createState() => _ProfileScanPageState();
}

class _ProfileScanPageState extends State<ProfileScanPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text('Scan QR', style: TextStyle(color: AppColors.black)),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.8)),
              ),
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.grey,
                controller: _controller,
                tabs: [
                  Tab(
                    icon: Text(
                      'My QR',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Scan QR',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 570.h,
              child: TabBarView(controller: _controller, children: [
                MyQRTab(),
                ScanQRTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class MyQRTab extends StatefulWidget {
  const MyQRTab({super.key});

  @override
  State<MyQRTab> createState() => _MyQRTabState();
}

class _MyQRTabState extends State<MyQRTab> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void initState() {
    super.initState();
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
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor.withOpacity(.1)),
          child: Column(
            children: [
              Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 22, color: AppColors.primaryColor),
              ),
              SizedBox(height: 10),
              Text(
                "Scan QR code to connect with your friends. A new\nway to become friends",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        SizedBox(height: 40),
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
                  overlayColor: AppColors.white,
                  cutOutBottomOffset: 0),
              onQRViewCreated: _onQRViewCreated,
              overlayMargin: const EdgeInsets.all(0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryColor)),
                child: Icon(
                  Icons.photo_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryColor)),
                child: Icon(
                  Icons.highlight_outlined,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ScanQRTab extends StatelessWidget {
  const ScanQRTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
