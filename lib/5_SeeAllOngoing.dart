import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/6_Dashboard.dart';

class SeeAllOngoing extends StatefulWidget {
  const SeeAllOngoing({super.key});

  @override
  State<SeeAllOngoing> createState() => _SeeAllOngoingState();
}

class _SeeAllOngoingState extends State<SeeAllOngoing> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF031531),
          body: Stack(
            children: [
              Image.asset(
                'assets/images/see-all-ongoing-bg.png',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: FloatingActionButton(
                        onPressed: () {
                          Get.to(
                            () => const Dashboard(),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Text(
                        'See all ongoing clubs and venues',
                        style: GoogleFonts.poppins(
                          fontSize: 31,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
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
