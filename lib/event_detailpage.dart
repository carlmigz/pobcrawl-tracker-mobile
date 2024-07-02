import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils.dart';
import 'package:gap/gap.dart';

class EventDetailpage extends StatefulWidget {
  final eFeatureImg;
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
      required this.eFeatureImg});

  @override
  State<EventDetailpage> createState() => _EventDetailpageState();
}

class _EventDetailpageState extends State<EventDetailpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Container(
          // color: Colors.amber,
          height: deviceSize.height * .5,
          child: Stack(
            children: [
              Image.network(
                widget.eFeatureImg,
                height: deviceSize.height * .5,
                fit: BoxFit.fitHeight,
              ),
              Image.asset(
                'assets/images/gradient_img.png',
                height: deviceSize.height * .5,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 35, color: Colors.white),
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
          ))
    ])));
  }
}
