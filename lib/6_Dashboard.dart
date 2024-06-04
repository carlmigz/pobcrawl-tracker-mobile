import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'assets/images/carousel/fun-roof-img.png',
    'assets/images/carousel/fun-roof-img.png',
    'assets/images/carousel/fun-roof-img.png',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Text(
                      'Tonight events',
                      style: GoogleFonts.poppins(
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D0AF1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'The Fun Roof',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.35,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/dashboard-home-indicator.png',
                                      width: 115,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 10.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/rec-ic.png',
                                          width: 20,
                                        ),
                                        Text(
                                          ' 01:10:21',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.35,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF626262),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CarouselSlider(
                            items: imageSliders,
                            carouselController: _controller,
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
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
                                children: imgList.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
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
                                            .withOpacity(_current == entry.key
                                                ? 0.9
                                                : 0.4),
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
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/time-ic.png',
                                      width: 20,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    Text(
                                      '12AM',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFFFFFFFF)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/loc-ic.png',
                                      width: 20,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '11th FLoor, 7846 Makati Ave. Poblacion, Makati City',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: const Color(0xFFFFFFFF)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
