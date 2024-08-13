import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/success_page.dart';

import 'package:pobcrawl_tracker/utils.dart';

class BookingPage extends StatefulWidget {
  final eName;
  final eDate;
  final eFeatureImg;
  final eTime;
  final eTicketFee;
  final eConvenienceFee;
  const BookingPage(
      {super.key,
      this.eName,
      this.eDate,
      this.eFeatureImg,
      this.eTime,
      this.eTicketFee,
      this.eConvenienceFee});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [
        Center(
          child: Column(children: [
            Gap(50),
            Text(
              widget.eName,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Gap(40),
            Container(
                height: 140,
                width: deviceSize.width * .9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.eFeatureImg,
                    fit: BoxFit.cover,
                  ),
                ))
          ]),
        ),
        Gap(40),
        Container(
          //    color: Colors.amber,
          width: deviceSize.width * .83,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.eName,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Gap(20),
                Row(
                  children: [
                    Image.asset('assets/icons/calendar_icon.png'),
                    Gap(20),
                    Text(
                      widget.eDate,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Gap(5),
                Row(
                  children: [
                    Image.asset('assets/icons/clock_icon.png'),
                    Gap(20),
                    Text(
                      widget.eTime + ' onwards ',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/icons/money_icon.png'),
                    Gap(20),
                    Text(
                      'Starting PHP. 1232.00',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Gap(20),
        Container(
          width: deviceSize.width * .85,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ticket',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'PHP. 1232.00',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Convenience Fee',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'PHP. 120.00',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Gap(15),
                Container(
                  width: deviceSize.width,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Gap(15),
                          Image.asset('assets/icons/coupon_icon.png'),
                          Gap(15),
                          Text(
                            'Apply Coupon',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFF5800),
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'PHP 1352.00',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Gap(50),
        InkWell(
          onTap: () {
            Get.to(() => SuccessPage(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 1500));
          },
          child: Container(
            width: deviceSize.width * .9,
            height: 45,
            decoration: BoxDecoration(
                color: Color(0xFFFF5800),
                borderRadius: BorderRadius.circular(7)),
            child: Center(
                child: Text(
              'Pay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ),
      ],
    ))));
  }
}
