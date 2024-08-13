import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'booking_page.dart';
import 'utils.dart';
import 'package:gap/gap.dart';

class EventDetailpage extends StatefulWidget {
  final eFeatureImg;
  final List<dynamic> eImgs;
  final eName;
  final eFee;
  final eAddress;
  final eDate;
  final eTime;
  const EventDetailpage(
      {super.key,
      required this.eName,
      required this.eFee,
      required this.eAddress,
      required this.eDate,
      required this.eTime,
      required this.eFeatureImg,
      required this.eImgs});

  @override
  State<EventDetailpage> createState() => _EventDetailpageState();
}

class _EventDetailpageState extends State<EventDetailpage> {
  String formatDate(String dateString) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the day with suffix
    String daySuffix = getDaySuffix(dateTime.day);
    String formattedDay = '${dateTime.day}$daySuffix';

    // Format the month
    String formattedMonth = DateFormat('MMMM').format(dateTime);

    // Combine day and month
    return '$formattedDay $formattedMonth';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String formatTime(String timeString) {
    // Parse the input time string into a DateTime object
    DateTime dateTime = DateFormat("HH:mm:ss").parse(timeString);

    // Format the time with AM/PM
    String formattedTime = DateFormat("h:mm a").format(dateTime);

    return formattedTime;
  }

  late String dateString = widget.eDate;
  late String formattedDate = formatDate(dateString);
  ///////////////////
  late String timeString = widget.eTime;
  late String formattedTime = formatTime(timeString);

  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
        Container(
            width: deviceSize.width,
            // color: Colors.amber,
            height: deviceSize.height * .425,
            child: Stack(
              children: [
                Image.network(
                  widget.eFeatureImg,
                  height: deviceSize.height * .425,
                  width: deviceSize.width,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/gradient_img.png',
                  height: deviceSize.height * .425,
                  width: deviceSize.width,
                  fit: BoxFit.fitHeight,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios,
                              size: 35, color: Colors.white)),
                      Gap(35),
                      Container(
                        width: deviceSize.width * .7,
                        child: Text(
                          widget.eName,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Gap(10),
        SizedBox(
          width: deviceSize.width * .85,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.eName,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Starting From',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color(0xffADADAD),
                        ),
                      ),
                      Text(
                        '₱' + widget.eFee + '  ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Color(0xffADADAD),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/loc_icon.png'),
                  Gap(15),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.eAddress,
                      style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        // color: Color(0xffADADAD),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date:",
                    style: GoogleFonts.poppins(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // color: Color(0xffADADAD),
                    ),
                  ),
                  Gap(15),
                  Expanded(
                    child: Text(
                      formattedDate,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // color: Color(0xffADADAD),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time:",
                    style: GoogleFonts.poppins(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // color: Color(0xffADADAD),
                    ),
                  ),
                  Gap(15),
                  Expanded(
                    child: Text(
                      formattedTime + ' onwards',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // color: Color(0xffADADAD),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(15),
              SizedBox(
                width: deviceSize.width * .8,
                child: CarouselSlider(
                  items: widget.eImgs
                      .map((item) => Container(
                            margin: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    item!,
                                    fit: BoxFit.cover,
                                    width: 700.0,
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // gradient: LinearGradient(
                                          //   colors: [
                                          //     Color.fromARGB(
                                          //         200, 0, 0, 0),
                                          //     Color.fromARGB(0, 208, 196, 196)
                                          //   ],
                                          //   begin: Alignment
                                          //       .bottomCenter,
                                          //   end:
                                          //       Alignment.topCenter,
                                          // ),
                                          ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.5,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF999999),
                    size: 10, // Adjust icon color as needed
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.eImgs.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 3.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF999999)
                                    : const Color(0xFFFF5800))
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF999999),
                    size: 10, // Adjust icon color as needed
                  ),
                ],
              ),
              Gap(20),
              InkWell(
                onTap: () {
                  Get.to(
                      () => BookingPage(
                            eName: widget.eName,
                            eFeatureImg: widget.eFeatureImg,
                            eDate: formattedDate,
                            eTime: formattedTime,
                            eConvenienceFee: '',
                            eTicketFee: '',
                          ),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 1500));
                },
                child: Container(
                  width: deviceSize.width,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5800),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                      child: Text(
                    'Book Now',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              )
            ],
          ),
        ),
      ]),
    )));
  }
}
