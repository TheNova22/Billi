// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'dart:developer';
import 'dart:ui';

import 'package:billi/modules/user_register_page/user_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../main.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';

class UserLoginPage extends StatefulWidget {
  UserLoginPage({Key? key}) : super(key: key);

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool _isHidden = true;
  final auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signIn() async {
    try {
      final res = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on PlatformException catch (error) {
      var message = "Incorrect Username or Password";
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   'LOGIN',
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       fontFamily: "Lato",
                    //       fontWeight: FontWeight.w800),
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: emailController,
                      width: 300,
                      height: 74,
                      title: 'Email',
                      hint: 'example@gmail.com',
                      suffixWidget: null,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      width: 300,
                      height: 74,
                      title: 'Password',
                      hint: 'Enter Password',
                      inputType: TextInputType.visiblePassword,
                      hideText: _isHidden,
                      // suffixWidget: null,
                      suffixWidget: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 18.0, 55.0, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Color(0xff034088),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomTextButton(
                      width: 300,
                      height: 43,
                      title: 'Login',
                      onTap: () {
                        signIn();
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Lato",
                                fontSize: 16.0)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              color: Color(0xff034088),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserRegisterPage()),
                            );
                          },
                        ))
                      ]),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Register as a ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Lato",
                                fontSize: 16.0)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            'Staff',
                            style: TextStyle(
                              color: Color(0xff034088),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            // TODO
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => StaffRegisterPage()),
                            // );
                          },
                        )),
                        TextSpan(
                            text: " or your ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Lato",
                                fontSize: 16.0)),
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            'Establishment',
                            style: TextStyle(
                              color: Color(0xff034088),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            // TODO
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MuseumRegisterPage()),
                            // );
                          },
                        ))
                      ]),
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

  void _togglePasswordView() {
    setState(() {
      log("Here");
      _isHidden = !_isHidden;
    });
  }
}
