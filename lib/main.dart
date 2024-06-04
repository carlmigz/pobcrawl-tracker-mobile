import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pobcrawl_tracker/3_GetStarted.dart';
import 'package:pobcrawl_tracker/4_ScanYourQr.dart';
import 'package:pobcrawl_tracker/2_SignUpPage.dart';
import 'package:pobcrawl_tracker/1_SplashScreen.dart';
import 'package:pobcrawl_tracker/5_SeeAllOngoing.dart';
import 'package:pobcrawl_tracker/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SeeAllOngoing(),
    );
  }
}
