import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pobcrawl_tracker/onboarding_page.dart';
import 'package:pobcrawl_tracker/login/login_page.dart';
import 'package:gap/gap.dart';
import 'package:pobcrawl_tracker/signup/services/signup_service.dart';
import 'package:pobcrawl_tracker/utils.dart';

import '../api/baseurl_api_class.dart';

class SignupPage extends StatefulWidget {
  final fname;
  final lname;
  final sex;
  final mobile;
  const SignupPage(
      {super.key,
      required this.fname,
      required this.lname,
      required this.sex,
      required this.mobile});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscureText = true;
  bool isChecked = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final BaseUrlApiClass baseUrlApiClass = BaseUrlApiClass();
  late final SignupService signupService;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true; // Show loader when fetching data
    });
    final String email = emailController.text.trim();

    final String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          colorText: const Color(0xFFFFFFFF));
      return;
    }

    if (passwordController.text != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match',
          colorText: const Color(0xFFFFFFFF));
      return;
    }
    final Map<String, dynamic> signupRes = await signupService.postSignup(
        firstName: widget.fname,
        lastName: widget.lname,
        email: emailController.text.trim(),
        pass: passwordController.text.trim(),
        mobile: widget.mobile,
        sex: widget.sex);

    try {
      if (signupRes['success'] == true) {
        setState(() {
          isLoading = false;
        });
        print(signupRes['success']);
        Get.to(
          () => LoginPage(),
          transition: Transition.fade,
          duration: const Duration(
            milliseconds: 1000,
          ),
        );
        Get.snackbar('Success!',
            'You have successfully created your account. Login now!',
            colorText: Colors.green);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      if (e is http.ClientException) {
        // Handle network-related exceptions (e.g., connection issues)
        print('Network error: $e');
        if (e.toString().contains("ClientException with SocketException")) {
          Get.snackbar('Error', 'You have no internet connection!',
              colorText: Colors.red);
        }
      } else {
        Get.snackbar('Error', signupRes['message'], colorText: Colors.red);
      }
    }
  }

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
    signupService = SignupService(baseUrlApiClass.baseUrl, baseUrlApiClass);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF031531),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
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
                                    const Padding(
                                        padding: EdgeInsets.all(10.0)),
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
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                                .hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: const Color(0xFFFFFFFF),
                                        hintText: 'Email address',
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
                                      cursorColor: const Color(0xFFFF5800),
                                    ),
                                    const Padding(padding: EdgeInsets.all(8.0)),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: obscureText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required!';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFFFFFFF),
                                        hintText: 'Password',
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
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF000000),
                                      ),
                                      cursorColor: const Color(0xFFFF5800),
                                    ),
                                    const Padding(padding: EdgeInsets.all(8.0)),
                                    TextFormField(
                                      controller: confirmPasswordController,
                                      obscureText: obscureText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required!';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFFFFFFF),
                                        hintText: 'Confirm password',
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
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF000000),
                                      ),
                                      cursorColor: const Color(0xFFFF5800),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.all(15.0)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              isChecked = !isChecked;
                                            });
                                          },
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                color: isChecked
                                                    ? const Color(0XFF1A396C)
                                                    : Colors.grey,
                                                width: 2.0,
                                              ),
                                              color: isChecked
                                                  ? const Color(0XFF1A396C)
                                                  : Colors.grey,
                                            ),
                                            child: isChecked
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 14.0,
                                                    color: Color(0xFFFFFFFF),
                                                  )
                                                : null,
                                          ),
                                        ),
                                        const VerticalDivider(),
                                        Text(
                                          'I accept the terms and privacy',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.all(10.0)),
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
                                            registerUser();
                                          }
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              'Sign up',
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
                                    const Padding(
                                        padding: EdgeInsets.all(10.0)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    Gap(10)
                                  ],
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
        ),
      ),
    );
  }
}
