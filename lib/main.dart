import 'package:billi/modules/intro_screens/intro_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO : When signing out the sharedprefs thign should be changed.
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
    final builder = FutureBuilder(
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
    Future<bool?> isLoggedIn() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getBool('loggedIn');
      } catch (error) {
        return false;
      }
    }

    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
        final offlineApp = FutureBuilder(
          builder: (context, pref) {
            if (pref.hasData && pref.data == true) {
              return Text("logged in");
            }
            return Text("logged out");
          },
          future: isLoggedIn(),
        );

        return snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi
            ? builder
            : MaterialApp(home: offlineApp);
      },
    );
  }
}
