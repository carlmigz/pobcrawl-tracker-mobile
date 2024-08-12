import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/signup/signup_page.dart';
import '../login_page.dart';
import '../utils.dart';
import 'package:gap/gap.dart';

class UserDetailsForm extends StatefulWidget {
  const UserDetailsForm({super.key});

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    // Delay the animation until the page is fully loaded
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }

  int _selectedValue = 1;
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF031531),
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            child: Stack(
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
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  //  top: 0,
                  // right: ,
                  left: _startAnimation
                      ? -100
                      : -300, // Start from off-screen left
                  top: 30,
                  child: Image.asset('assets/images/decor-1.png'),
                ),
                AnimatedPositioned(
                  // top: 0,
                  left: 120,
                  top: _startAnimation ? 5 : -200,
                  duration: Duration(milliseconds: 1500),
                  child: Image.asset('assets/images/decor-2.png'),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastOutSlowIn,
                  left: 0,
                  right: 0,
                  top: _startAnimation
                      ? MediaQuery.of(context).size.height * 0.29
                      : deviceSize.height, // Adjust as needed
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60.0),
                              topRight: Radius.circular(60.0),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(padding: EdgeInsets.all(5.0)),
                                  Text(
                                    'Welcome to Pobcrawl!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'where the night comes alive',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(10.0)),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  Create Account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFFF5800),
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(8.0)),
                                  SizedBox(
                                    width: deviceSize.width,
                                    height: 60,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: deviceSize.width * .4,
                                          child: TextFormField(
                                            controller: _fname,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'First Name is Required!';
                                              }
                                              // Directly place the regex pattern inside the validator

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFFFFFFF),
                                              hintText: 'First Name',
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: const Color.fromARGB(
                                                    125, 0, 0, 0),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(15.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF000000),
                                            ),
                                            cursorColor:
                                                const Color(0xFFFF5800),
                                          ),
                                        ),
                                        SizedBox(
                                          width: deviceSize.width * .4,
                                          child: TextFormField(
                                            controller: _lname,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Last Name is Required!';
                                              }
                                              // Directly place the regex pattern inside the validator

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFFFFFFF),
                                              hintText: 'Last Name',
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: const Color.fromARGB(
                                                    125, 0, 0, 0),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(15.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xFF000000),
                                            ),
                                            cursorColor:
                                                const Color(0xFFFF5800),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  TextFormField(
                                    controller: _mobile,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your valid mobile number!';
                                      }
                                      // Directly place the regex pattern inside the validator
                                      if (!RegExp(r'^09\d{9}$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid mobile number';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFFFFFFFF),
                                      hintText: 'Mobile Number',
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            const Color.fromARGB(125, 0, 0, 0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.all(15.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xFF000000),
                                    ),
                                    cursorColor: const Color(0xFFFF5800),
                                  ),
                                  Gap(5),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  Sex',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFFF5800),
                                      ),
                                    ),
                                  ),
                                  Gap(5),
                                  SizedBox(
                                    width: deviceSize.width,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: deviceSize.width * .4,
                                          child: ListTile(
                                            title: Text(
                                              'Male',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            leading: Radio<int>(
                                              value: 1,
                                              groupValue: _selectedValue,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  _selectedValue = value!;
                                                });
                                              },
                                              activeColor: Color(0xFFFF5800),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: deviceSize.width * .45,
                                          child: ListTile(
                                            title: Text(
                                              'Female',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            leading: Radio<int>(
                                              value: 2,
                                              groupValue: _selectedValue,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  _selectedValue = value!;
                                                });
                                              },
                                              activeColor: Color(0xFFFF5800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(10),
                                  const Padding(padding: EdgeInsets.all(10.0)),
                                  SizedBox(
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0xFFFF5800),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        final isValidForm =
                                            _formKey.currentState!.validate();

                                        if (isValidForm) {
                                          Get.to(
                                              () => SignupPage(
                                                    fname: _fname.text.trim(),
                                                    lname: _lname.text.trim(),
                                                    sex: _selectedValue == 1
                                                        ? 'Male'
                                                        : 'Female',
                                                    mobile: _mobile.text.trim(),
                                                  ),
                                              transition:
                                                  Transition.rightToLeft,
                                              duration: const Duration(
                                                  milliseconds: 100));
                                        }
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            'Next',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(10.0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?  ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => const LoginPage(),
                                              transition:
                                                  Transition.rightToLeft,
                                              duration: const Duration(
                                                  milliseconds: 100));
                                        },
                                        child: Text(
                                          'Log in',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(20)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  top: 120,
                  right: _startAnimation ? -60 : -300,
                  // left: MediaQuery.of(context).size.width * 0.6,
                  child: Image.asset('assets/images/decor-3.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
