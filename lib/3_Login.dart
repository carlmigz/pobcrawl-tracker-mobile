import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pobcrawl_tracker/2_SignUp.dart';
import 'package:pobcrawl_tracker/3_GetStarted.dart';
import 'package:pobcrawl_tracker/6_Dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  bool isChecked = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> userLogin() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          colorText: const Color(0xFFFFFFFF));
      return;
    }

    final url =
        Uri.parse('https://tracker-api.pobcrawl.com/api/v1/accounts/login');
    print('Sending POST request to $url');
    print('Email: $email');
    print('Password: $password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'emailAddress': email,
        'password': password,
      }),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Login successful',
          colorText: const Color(0xFFFFFFFF));
      Get.to(() => const Dashboard(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100));
    } else {
      final responseBody = jsonDecode(response.body);
      Get.snackbar('Error', responseBody['message'] ?? 'Login failed',
          colorText: const Color(0xFFFFFFFF));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Positioned(
                top: 0,
                right: 210,
                child: Image.asset('assets/images/decor-1.png'),
              ),
              Positioned(
                top: 0,
                left: 120,
                child: Image.asset('assets/images/decor-2.png'),
              ),
              Positioned(
                top: 80,
                left: 230,
                child: Image.asset('assets/images/decor-3.png'),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
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
                              TextField(
                                controller: emailController,
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
                              TextField(
                                controller: passwordController,
                                obscureText: obscureText,
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFFFF5800),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: userLogin,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        'Login',
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
                              const Padding(padding: EdgeInsets.all(30.0)),
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
                                      Get.to(() => const SignUp(),
                                          transition: Transition.rightToLeft,
                                          duration: const Duration(
                                              milliseconds: 100));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
