import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/qr/qrscan_page.dart';
import 'package:pobcrawl_tracker/utils.dart';
import 'package:gap/gap.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _bgAnimation = false;
  bool _widgetAnimation = false;

  @override
  void initState() {
    super.initState();
    // Delay the animation until the page is fully loaded
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _bgAnimation = true;
      });
    });
    // Delay the animation until the page is fully loaded
    Future.delayed(Duration(milliseconds: 1600), () {
      setState(() {
        _widgetAnimation = true;
      });
      _triggerFadeIn();
    });
  }

  double _opacity = 0.0;
  void _triggerFadeIn() {
    // Delay for smooth transition after page navigation
    Future.delayed(Duration(milliseconds: 1700), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff031531),
          body: Stack(
            children: [
              AnimatedPositioned(
                top: _bgAnimation ? 0 : -800,
                duration: Duration(milliseconds: 1500),
                child: Container(
                  width: deviceSize.width,
                  height: deviceSize.height,
                  child: Image.asset(
                    'assets/images/onboard_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Gap(deviceSize.height * .25),
                  Image.asset(
                    'assets/images/qr-img.png',
                    //   width: deviceSize.width * .7,
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(deviceSize.height * .14),
                        Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: 35,
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
                                () => const QrscanPage(),
                                transition: Transition.fadeIn,
                                duration: const Duration(
                                  milliseconds: 1500,
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
                ],
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastOutSlowIn,
                // top: -30,
                // left: 10,
                left:
                    _widgetAnimation ? -10 : -300, // Start from off-screen left
                top: 10,
                child: Image.asset(
                  'assets/images/decor-4.png',
                  width: 200,
                  height: 300,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                top: 20,
                right: _widgetAnimation ? -30 : -300,
                child: Image.asset(
                  'assets/images/decor-5.png',
                  width: 200,
                  height: 300,
                ),
              ),
              AnimatedPositioned(
                curve: Curves.fastOutSlowIn,
                left: 120,
                top: _widgetAnimation ? 320 : -200,
                duration: Duration(milliseconds: 1500),
                child: Image.asset(
                  'assets/images/decor-6.png',
                  width: 200,
                  height: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
