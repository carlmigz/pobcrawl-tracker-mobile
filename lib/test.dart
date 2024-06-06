import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pobcrawl_tracker/3_GetStarted.dart';
import 'package:http/http.dart' as http;

class TestAPI extends StatefulWidget {
  const TestAPI({Key? key}) : super(key: key);

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  Future<void> TestAPI() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Make a POST request to the register endpoint
    var response = await http.post(
      Uri.https('tracker-api.pobcrawl.com', '/api/v1/accounts/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'emailAddress': email,
        'password': password,
      }),
    );

    // Parse the response
    if (response.statusCode == 200) {
      // Registration successful, handle navigation or other actions
      // For example, navigate to the next screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
    } else {
      // Registration failed, display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: TestAPI,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
