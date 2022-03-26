// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:developer';

import '../assign_roles/assign_roles.dart';
import 'components/operation_widget.dart';

import '../../configs/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'pages/home_page.dart';

class _BarChart extends StatelessWidget {
  const _BarChart({Key? key, required this.barGroupData}) : super(key: key);
  final List<BarChartGroupData> barGroupData;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => barGroupData;
}

class MuseumHomePage extends StatefulWidget {
  MuseumHomePage({Key? key, this.mId = "B1ksoQQSYyNw9oCnXwYv"})
      : super(key: key);
  final String mId;
  @override
  State<MuseumHomePage> createState() => _MuseumHomePageState();
}

class _MuseumHomePageState extends State<MuseumHomePage> {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  List<double> data = [0, 0, 0, 0, 0, 0, 0];
  List<String> staff = [];
  String name = "";
  String address = "";
  String imgUrl = "";
  int customersArrival = 0;
  num price =
      0; // IN FUTURE BETTER TO ADD A FIELD "PRICE" IN MUSUEM DB , TEMP CALCULATING
  int souvenirs = 32;
  Future getDetails() async {
    List<String> transactions = [];
    List<String> tempStaff = [];
    await store.collection("museums").doc(widget.mId).get().then((value) {
      transactions = List<String>.from(value.data()!["transactions"] as List);
      setState(() {
        tempStaff = List<String>.from(value.data()!["staff"] as List);
        // log(value.data()!["souvenirs"]);
        // souvenirs = value.data()!["souvenirs"].length();
        address = value.data()!["address"] +
            " , " +
            value.data()!["city"] +
            " , " +
            value.data()!["state"];
        name = value.data()!["name"];
        imgUrl = value.data()!["imageUrls"][0];
        customersArrival = value.data()!["visitingCount"];
      });
    });
    for (int i = 0; i < tempStaff.length; i++) {
      await store
          .collection("staff")
          .doc(tempStaff[i].trim())
          .get()
          .then((value) {
        staff.add(value.data()!["name"]);
      });
    }
    for (int i = transactions.length - 1; i >= 0; i--) {
      bool flag = false;
      await store
          .collection("transactions")
          .doc(transactions[i].trim())
          .get()
          .then((value) {
        int timestamp = value.data()!['timestamp'];
        setState(() {
          price += value.data()!["price"];
        });
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
        int diff = DateTime.now().difference(date).inDays;
        if (diff >= 7) {
          flag = true;

          return;
        } else {
          data[diff] += value.data()!["people"];
        }
      });
      if (flag) {
        break;
      }
    }
  }

  List<BarChartGroupData> dataMaker(data) {
    List<BarChartGroupData> res = [];
    for (int i = 0; i < data.length; i++) {
      res.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }
    return res;
  }

  @override
  void initState() {
    getDetails().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<BarChartGroupData> barData = dataMaker(data);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.location_on,
          color: Palette.orange,
          size: 40.0,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // 'Supreme Museum',
              name,
              style: TextStyle(color: Palette.orange, fontSize: 18.0),
            ),
            Text(
              // 'Area, Bangalore',
              address,
              style: TextStyle(color: Colors.black, fontSize: 10.0),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                  imgUrl,
                  // 'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png'),
                  // backgroundColor: Colors.transparent,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
              child: Text(
                "Today's Statistics",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  width: width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        customersArrival.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Palette.darkgreen,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Customer Arrivals',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  width: width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        // '1500',
                        price.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Palette.darkgreen,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: width / 5,
                        child: Text(
                          'Total Income',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  width: width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        // '32', // HARDCODED FOR NOW
                        souvenirs.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Palette.red,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: width / 5,
                        child: Text(
                          'Souvenirs Sold',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
              child: Text(
                "Weekly Analysis",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: AspectRatio(
                aspectRatio: 1.7,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: const Color(0xff2c4260),
                  child: _BarChart(
                    barGroupData: barData,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
              child: Text(
                "Operations",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Wrap(
                  children: [
                    // TODO: SHOULD ADD ROUTES
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AssignRoles()))
                      },
                      child: OperationWidget(
                          icon: Icons.person_add_alt_1_outlined,
                          title: 'Assign roles'),
                    ),
                    OperationWidget(
                        icon: Icons.qr_code_scanner, title: 'Scan ticket'),
                    OperationWidget(
                        icon: Icons.attach_money, title: 'Update Prices'),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogPage()))
                      },
                      child: OperationWidget(
                          icon: Icons.checklist_rtl_rounded,
                          title: 'Check Logs'),
                    ),
                    OperationWidget(
                        icon: Icons.workspace_premium, title: 'Apply Premium'),
                    OperationWidget(
                        icon: Icons.feedback_outlined, title: 'Feedback'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 5.0),
              child: Text(
                "Staff / Employees",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,

                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.all(10),
                  itemExtent: 100,
                  scrollDirection: Axis.horizontal,
                  // )
                  itemCount: staff.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(staff[index]);
                    // }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width / 4,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png'),
                              // backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              staff[index],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
