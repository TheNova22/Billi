// ignore_for_file: prefer_const_constructors

import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MuseumRegisterPage extends StatefulWidget {
  MuseumRegisterPage({Key? key}) : super(key: key);

  @override
  State<MuseumRegisterPage> createState() => _MuseumRegisterPageState();
}

// TODO : Add a focus so that as the user presses  enter, he/she directly goes to next text field.

class _MuseumRegisterPageState extends State<MuseumRegisterPage> {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  TextEditingController establishmentNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController workProofURL = TextEditingController();

  void signUp() async {
    try {
      final res = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await store.collection('staff').doc(res.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'role': 'admin',
        'sid': res.user!.uid,
        'schedule': [""],
      });

      await store.collection('museums').add({
        'city': cityController.text.trim(),
        'state': stateController.text.trim(),
        'address': addressController.text.trim(),
        "description": descriptionController.text.trim(),
        'approved': false,
        'name': establishmentNameController.text.trim(),
        'mobile': mobileController.text.trim(),
        'capacity': capacityController.text.trim(),
        'visitingCount': 0,
        'slots': [""],
        'imageUrls': [""],
        'transactions': [''],
        "rating": 0,
        "workProofUrl": workProofURL.text.trim(),
        "staff": [res.user!.uid]
      }).then((value) {
        store.collection('staff').doc(res.user!.uid).update({"mid": value.id});
        store
            .collection('museums')
            .doc(value.id)
            .update({"mid": value.id, "adminId": res.user!.uid});
        store.collection('museums').doc(value.id).collection('souvenirs').add({
          'itemName': "Dummy Item Ignored in code",
          'iid': "ignore",
          'itemPrice': 0,
          'itemStock': 0,
          'numberOfPurchases': 0,
          'imageUrls': [""]
        });
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
                'museum reg page',
                style: TextStyle(fontSize: 30),
              ),
              CustomTextField(
                controller: establishmentNameController,
                width: 300,
                height: 74,
                title: 'Establishment name',
                hint: 'Enter Establishment  name here',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: cityController,
                width: 300,
                height: 74,
                title: 'City',
                hint: 'Enter city',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              CustomTextField(
                controller: stateController,
                width: 300,
                height: 74,
                title: 'State name',
                hint: 'State name',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: addressController,
                width: 300,
                height: 74,
                title: 'Address',
                hint: 'Enter address',
                suffixWidget: null,
                inputType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: nameController,
                width: 300,
                height: 74,
                title: 'Name',
                hint: 'Enter your name here',
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
                hint: 'Your email address',
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
                controller: workProofURL,
                width: 300,
                height: 74,
                title: 'Workproofurl',
                hint: 'workproofurl',
                suffixWidget: null,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: descriptionController,
                width: 300,
                height: 74,
                title: 'Description',
                hint: 'Enter a short description for the museum',
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
