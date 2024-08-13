import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/6_Dashboard.dart';
import 'package:pobcrawl_tracker/utils.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Gap(deviceSize.width * .35),
                Image.asset('assets/icons/success_icon.png'),
                Gap(30),
                Text(
                  'Payment',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5800),
                  ),
                ),
                Gap(5),
                Text(
                  'Successful!',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5800),
                  ),
                ),
                Gap(15),
                Text(
                  'Order ID: 112234',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF5800),
                  ),
                ),
                Gap(10),
                Text(
                  'Tickets has been mailed to',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Color(0xFF7A797C),
                  ),
                ),
                Gap(10),
                Text(
                  'Email/SMS',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Color(0xFF7A797C),
                  ),
                ),
                Gap(deviceSize.height * .25),
                InkWell(
                  onTap: () {
                    Get.to(() => Dashboard(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 1500));
                  },
                  child: Text(
                    'Go to Home',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Gap(20),
                InkWell(
                  onTap: () {
                    // Get.to(() => SuccessPage(),
                    //     transition: Transition.rightToLeft,
                    //     duration: const Duration(milliseconds: 100));
                  },
                  child: Container(
                    width: deviceSize.width * .9,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5800),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Text(
                      'Download Ticket',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
