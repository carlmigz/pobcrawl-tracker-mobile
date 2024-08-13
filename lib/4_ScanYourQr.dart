import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/5_SeeAllOngoing.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '6_Dashboard.dart';

class ScanYourQR extends StatefulWidget {
  const ScanYourQR({super.key});

  @override
  State<ScanYourQR> createState() => _ScanYourQRState();
}

class _ScanYourQRState extends State<ScanYourQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  String? qrText;
  bool isScanning = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanning) {
        setState(() {
          isScanning = true;
          qrText = scanData.code;
          if (qrText != null) {
            controller.pauseCamera();
            controller.dispose();
            Get.to(() => const Dashboard(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 400))
                ?.then((value) {
              setState(() {
                isScanning = false;
                controller.resumeCamera();
              });
            });
          }
        });
      }
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF031531),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/topographic.png',
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scan your QR Code, Crawler!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                    ),
                    Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                            borderColor: Colors.white,
                            borderLength: 50,
                            borderWidth: 5,
                            cutOutSize: 600,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                    ),
                    Container(
                      width: 250,
                      //   color: Colors.amber,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: isScanning
                              ? const Color(0xFFFF5800).withOpacity(0.5)
                              : const Color(0xFFFF5800),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isScanning
                            ? null
                            : () {
                                // Start scanning for QR codes
                                setState(() {
                                  isScanning = true;
                                });
                                controller?.resumeCamera();
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/scan-qr-ic.png',
                              width: 15,
                            ),
                            Text(
                              '  Scan QR Code',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
