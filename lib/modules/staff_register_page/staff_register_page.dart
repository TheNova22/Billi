// ignore_for_file: prefer_const_constructors

import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffRegisterPage extends StatefulWidget {
  StaffRegisterPage({Key? key}) : super(key: key);

  @override
  State<StaffRegisterPage> createState() => _StaffRegisterPageState();
}

// TODO : Add a focus so that as the user presses  enter, he/she directly goes to next text field.

class _StaffRegisterPageState extends State<StaffRegisterPage> {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController museumController = TextEditingController();

  void signUp() async {
    try {
      final res = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      var mid = "";
      final mname = museumController.text.trim();
      await store.collection('museums').get().then((value) {
        var arr = value.docs;
        for (int i = 0; i < arr.length; i++) {
          if (arr[i].data()['name'] == mname) {
            mid = arr[i].data()['mid'];
          }
        }
      });
      await store.collection('staff').doc(res.user!.uid).set({
        'museumName': museumController.text.trim(),
        'mid': mid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'gender': genderController.text.trim(),
        'role': '',
        'sid': res.user!.uid,
        'schedule': [""],
      });

      await store.collection('museums').doc(mid).update({
        "staff": FieldValue.arrayUnion([res.user!.uid])
      });
      final pref = await SharedPreferences.getInstance();
      pref.setBool('loggedIn', true);
      Navigator.of(context).pop();
    } on PlatformException catch (error) {
      var message = "Something's wrong";
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
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'staff reg page',
                style: TextStyle(fontSize: 30),
              ),
              CustomTextField(
                controller: nameController,
                width: 300,
                height: 74,
                title: 'Name',
                hint: 'Enter staff name here',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                width: 300,
                height: 74,
                title: 'Email',
                hint: 'samuel007@gmail.com',
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
                hint: '',
                inputType: TextInputType.visiblePassword,
                hideText: true,
                suffixWidget: null,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: mobileController,
                width: 300,
                height: 74,
                title: 'Mobile Number',
                hint: '+916969696420',
                suffixWidget: null,
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: genderController,
                width: 300,
                height: 74,
                title: 'Gender',
                hint: 'Sigma Male',
                suffixWidget: null,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: museumController,
                width: 300,
                height: 74,
                title: 'museum name',
                hint: 'Enter your museum id here',
                suffixWidget: null,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextButton(
                width: 300,
                height: 43,
                title: 'Sign Up',
                onTap: () {
                  signUp();
                  Navigator.pop(context);
                  // signIn();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
