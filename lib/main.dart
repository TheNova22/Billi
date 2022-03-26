import 'package:billi/modules/intro_screens/intro_screen.dart';
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
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
