import 'dart:math' as math;
import '../../../configs/palette.dart';
import '../components/log_card.dart';
import 'package:flutter/material.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        title: Text("Log Book"),
        leading: Transform.rotate(
            angle: -math.pi / 2,
            child: Icon(Icons.arrow_circle_up_rounded,
                color: Palette.black, size: 35)),
        titleTextStyle: TextStyle(
            fontSize: 22, color: Palette.black, fontWeight: FontWeight.w600),
        actions: [
          Icon(Icons.filter_alt_sharp, color: Palette.blue, size: 25),
          SizedBox(width: 20),
          Icon(Icons.download, color: Palette.blue, size: 25),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(22.0),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                hintText: "Try Jacque Rolinson",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              ListView.builder(itemCount: 15, itemBuilder: (_, i) => LogCard()),
        ),
      ),
    );
  }
}
