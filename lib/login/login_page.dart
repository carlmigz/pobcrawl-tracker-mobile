import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pobcrawl_tracker/login/services/login_service.dart';
import 'package:pobcrawl_tracker/signup/signup_page.dart';
import 'package:pobcrawl_tracker/onboarding_page.dart';
import 'package:pobcrawl_tracker/home_page.dart';
import 'package:pobcrawl_tracker/signup/user_details_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gap/gap.dart';

import '../api/baseurl_api_class.dart';
import '../utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  bool isChecked = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final BaseUrlApiClass baseUrlApiClass = BaseUrlApiClass();
  late final LoginService loginService;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _startAnimation = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Delay the animation until the page is fully loaded
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _startAnimation = true;
      });
    });
    loginService = LoginService(baseUrlApiClass.baseUrl, baseUrlApiClass);
  }

  Future<void> loginFunc() async {
    setState(() {
      isLoading = true; // Show loader when fetching data
    });

    final Map<String, dynamic> loginRes = await loginService.postLogin(
      email: emailController.text.trim(),
      pass: passwordController.text.trim(),
    );

    try {
      if (loginRes['success'] == true) {
        setState(() {
          isLoading = false;
        });
        print(loginRes['success']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Get.to(
          () => OnboardingPage(),
          transition: Transition.fade,
          duration: const Duration(
            milliseconds: 1000,
          ),
        );
      } else {
        Get.snackbar('Error', loginRes['message'], colorText: Colors.red);
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
        Get.snackbar('Error', loginRes['message'], colorText: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF031531),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
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
                          height: deviceSize.height,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60.0),
                              topRight: Radius.circular(60.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.end,
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
                                const Padding(padding: EdgeInsets.all(15.0)),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 30,
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
                                    filled: true,
                                    fillColor: const Color(0xFFFFFFFF),
                                    hintText: 'Email address',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: const Color.fromARGB(125, 0, 0, 0),
                                    ),
                                    contentPadding: const EdgeInsets.all(20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: const Color.fromARGB(125, 0, 0, 0),
                                    ),
                                    contentPadding: const EdgeInsets.all(20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
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
                                const Padding(padding: EdgeInsets.all(15.0)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                const Padding(padding: EdgeInsets.all(10.0)),
                                Container(
                                  height: 60,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0xFFFF5800),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      final isValidForm =
                                          _formKey.currentState!.validate();
                                      if (isValidForm && !isLoading) {
                                        loginFunc();
                                      }
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: !isLoading
                                            ? Text(
                                                'Login',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: Colors.white,
                                              )),
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No Account?  ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => const UserDetailsForm(),
                                        );
                                      },
                                      child: Text(
                                        'Create Account',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
