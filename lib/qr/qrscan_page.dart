import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/5_SeeAllOngoing.dart';
import 'package:pobcrawl_tracker/qr/services/get_event_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/baseurl_api_class.dart';
import '../home_page.dart';

class QrscanPage extends StatefulWidget {
  const QrscanPage({super.key});

  @override
  State<QrscanPage> createState() => _QrscanPageState();
}

class _QrscanPageState extends State<QrscanPage> {
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
            // Map<String, dynamic> _json = jsonDecode(qrText!);
            // String eventId = _json['eventId'];
            // print('eventID: $eventId');

            // _getEventFunc(eventId);
            Get.off(() => HomePage(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 1000));

            controller.pauseCamera();
            setState(() {
              isScanning = false;
              controller.stopCamera();
            });
          }
        });
      }
    });
  }

  final BaseUrlApiClass baseUrlApiClass = BaseUrlApiClass();
  late final GetEventService getEventService;

  @override
  void initState() {
    super.initState();
    getEventService = GetEventService(baseUrlApiClass.baseUrl, baseUrlApiClass);
  }

  bool _isLoading = false;

  Future<void> _getEventFunc(String eventId) async {
    setState(() {
      _isLoading = true;
    });
    print('eventID: $eventId');

    try {
      Map<String, dynamic> response =
          await getEventService.getEvent(eventId: eventId);
      print(response['success']);
      if (response['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('eventDetails', response.toString());
        Get.off(
            () => HomePage(
                  eventDetails: response,
                ),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 1000));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
