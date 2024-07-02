import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pobcrawl_tracker/2_SignUp.dart';
import 'package:pobcrawl_tracker/3_Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.to(
        () => const Login(),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 400,
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/splash-img.png',
            width: 201,
          ),
        ),
      ),
    );
  }
}
