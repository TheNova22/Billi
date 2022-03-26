import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewSaved extends StatefulWidget {
  ViewSaved({Key? key}) : super(key: key);

  @override
  State<ViewSaved> createState() => _ViewSavedState();
}

class _ViewSavedState extends State<ViewSaved> {
  List<String> logList = [];
  Future getLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? logs = prefs.getString('logs');
    String date = DateFormat.yMd().format(DateTime.now());
    if (logs != null) {
      final deets = jsonDecode(logs);
      if (deets.containsKey(date)) {
        logList = List<String>.from(deets[date]! as List);
      }
    }
  }

  @override
  void initState() {
    getLogs().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(logList.length, (index) => Text(logList[index])),
        ),
      ),
    );
  }
}
