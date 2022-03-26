import 'package:billi/modules/account/account.dart';
import 'package:billi/modules/qr_scanner/qr_scanner.dart';
import 'package:billi/modules/view_saved/view_saved.dart';
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:auto_size_text/auto_size_text.dart';
import 'package:billi/configs/palette.dart';
import 'package:billi/pages/splash_screen.dart';

import 'package:billi/widgets/common_navigation_bar.dart';
import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/show_ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Account());
  }
}
