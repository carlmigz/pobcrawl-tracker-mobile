import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pobcrawl_tracker/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '6_Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(milliseconds: 150));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pobcrawl Tracker',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isLogged = snapshot.data!;
            return AnimatedSplashScreen(
              splash: 'assets/images/splash.gif',
              splashIconSize: 2000.0,
              centered: true,
              nextScreen: isLogged ? Dashboard() : LoginPage(),
              backgroundColor: Color(0xff031531),
              duration: 5500,
            );
          } else {
            return CircularProgressIndicator(); // Show a loading indicator
          }
        },
      ),
    );
  }
}
