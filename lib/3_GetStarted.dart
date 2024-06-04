import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/4_ScanYourQr.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF031531),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF031531),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5800),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5800),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60.0),
                        ),
                      ),
                      child: Image.asset('assets/images/qr-img.png'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF031531),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started',
                              style: GoogleFonts.poppins(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                            Image.asset('assets/images/divider-img.png'),
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            Text(
                              'Go on your epic pub crawl adventure with PobCrawl and join the Crawlers!',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFFFFFFFF),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                            ),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Get.to(
                                    () => const ScanYourQR(),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(
                                      milliseconds: 400,
                                    ),
                                  );
                                },
                                backgroundColor: Color(0xFF5B84C4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 0,
                                highlightElevation: 0,
                                splashColor: Colors.transparent,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        spreadRadius: 6,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.black,
                                    size: 25.6, // Adjust icon color as needed
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -30,
                left: 10,
                child: Image.asset(
                  'assets/images/decor-4.png',
                  width: 150,
                ),
              ),
              Positioned(
                top: 30,
                left: 260,
                child: Image.asset(
                  'assets/images/decor-5.png',
                  width: 100,
                ),
              ),
              Positioned(
                top: 280,
                left: 170,
                child: Image.asset(
                  'assets/images/decor-6.png',
                  width: 130,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
