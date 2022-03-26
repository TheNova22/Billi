
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:billi/configs/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../main.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State< SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
                child: Image.asset(
                  "assets/logo/logo.png",
                  width: 100.0,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bill - i',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: "Allura",
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'e-tickets for all your excursions! ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      "assets/logo/splash.png",
                      width: 300,
                      height: 300,
                    ),

                      ]),
                    ),
                  ],
                ),
              ),
          ),
        );
  }


}
