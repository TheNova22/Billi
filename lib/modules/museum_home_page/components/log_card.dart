import '../../../configs/palette.dart';
import 'package:flutter/material.dart';

class LogCard extends StatelessWidget {
  LogCard({Key? key}) : super(key: key);
  String name = "Rey Mysterio";
  String email = "rey619@mail.com";
  String gate = "Gate 7B";
  String amount = "750";
  String entrants_number = "2";
  String souvenirs_number = "3";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Stack(
          children: [
            logInfo,
            logPic,
          ],
        ),
      ),
    );
  }

  final logInfo = Container(
    padding: EdgeInsets.only(left: 15),
    height: 80,
    margin: new EdgeInsets.only(left: 25.0),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15)),
      color: Palette.white,
      border: Border.all(color: Color(0xffAAAAAA), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: Offset(1, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rey Mysterio",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("rey619@mail.com", style: TextStyle(fontSize: 13)),
                Text("5 entrants | 3 souvenirs", style: TextStyle(fontSize: 13))
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(children: [
            Text("Gate 7B", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("320")
          ]),
        ],
      ),
    ),
  );

  final logPic = Container(
    alignment: FractionalOffset.centerLeft,
    margin: new EdgeInsets.symmetric(vertical: 15.0),
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.orange[600],
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Image.asset("assets/logo/logo.png", fit: BoxFit.cover),
    ),
  );
}
