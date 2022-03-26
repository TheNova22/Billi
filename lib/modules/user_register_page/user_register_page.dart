// ignore_for_file: prefer_const_constructors
import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserRegisterPage extends StatefulWidget {
  UserRegisterPage({Key? key}) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

// TODO : Add a focus so that as the user presses  enter, he/she directly goes to next text field.

class _UserRegisterPageState extends State<UserRegisterPage> {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController handiController = TextEditingController();
  TextEditingController covidController = TextEditingController();

  void signUp() async {
    try {
      final res = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await store.collection('users').doc(res.user!.uid).set({
        'uid': res.user!.uid,
        'name': nameController.text.trim(),
        'age': int.parse(ageController.text.trim()),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'gender': genderController.text.trim(),
        'isHandicap': handiController.text.trim().isNotEmpty,
        'handicapUrl': handiController.text.trim(),
        'vaccineUrl': covidController.text.trim(),
        'tickets': [""],
        'feedbacks': [""]
      });
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
                'User reg page',
                style: TextStyle(fontSize: 30),
              ),
              CustomTextField(
                controller: nameController,
                width: 300,
                height: 74,
                title: 'Name',
                hint: 'Kong King',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: ageController,
                width: 300,
                height: 74,
                title: 'Age',
                hint: '69',
                suffixWidget: null,
                inputType: TextInputType.number,
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
                controller: handiController,
                width: 300,
                height: 74,
                title: 'Handicap',
                hint: 'Certificate URL',
                suffixWidget: null,
                inputType: TextInputType.url,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: covidController,
                width: 300,
                height: 74,
                title: 'Covid-19 Vaccine',
                hint: 'Vaccination URL',
                suffixWidget: null,
                inputType: TextInputType.url,
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
