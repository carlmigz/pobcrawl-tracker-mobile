import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                              padding: EdgeInsets.all(5.0),
                            ),
                            Image.asset(
                              'assets/images/FAB-img.png',
                              width: 150,
                            )
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
