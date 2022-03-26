import 'package:billi/modules/model_check/model_ui.dart';
import 'package:billi/modules/qr_scanner/qr_scanner.dart';
import 'package:billi/modules/view_saved/view_saved.dart';
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:auto_size_text/auto_size_text.dart';
import 'package:billi/configs/palette.dart';
import 'package:billi/pages/splash_screen.dart';

import 'package:billi/widgets/common_navigation_bar.dart';
import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/show_ticket.dart';
import 'package:camera/camera.dart';
import 'package:billi/modules/intro_screens/intro_screen.dart';
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // late List<CameraDescription> cameras;
  // cameras = await availableCameras();

  // await Firebase.initializeApp();
  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: MyHomePage(
  //     cameras,
  //   ),
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// todo: make this a Futurebuilder widget so that we can show waiting progress indicator as it loads
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    final stream = StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasData) {
          return Container(
            child: Text("signed in"),
          );
        }
        return IntroScreen();
      },
    );
    // TODO : Add offline check with sharedpref.. if offline, then just direct to
    final app = MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: stream);
    return FutureBuilder(
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return app;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: Firebase.initializeApp(),
    );
  }
}
