// Todo: used 2 appbars ; might be bad practice ; figure out some other practice
import 'dart:convert';

import 'package:billi/configs/palette.dart';
import 'package:billi/modules/user_ticket_page/components/ticket_card.dart';
import 'package:billi/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserTicketPage extends StatefulWidget {
  UserTicketPage({Key? key}) : super(key: key);

  @override
  State<UserTicketPage> createState() => _UserTicketPageState();
}

class _UserTicketPageState extends State<UserTicketPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  String uid = "";
  String name = "";
  String email = '';
  List<String> datas = [];
  List<int> prices = [];
  List<String> mids = [];
  List<String> muses = [];
  List<int> visitedI = [];
  List<int> yetToI = [];

  Future getTicket() async {
    uid = auth.currentUser!.uid;
    List<String> tids = [];
    await store.collection("users").doc(uid).get().then((value) {
      tids = List<String>.from(value.data()!["tickets"] as List);
      name = value.data()!["name"];
      email = value.data()!["email"];
    });
    print(tids);
    for (int i = tids.length - 1; i >= 0; i--) {
      await store.collection("transactions").doc(tids[i]).get().then((value) {
        if (value.data()!["entered"] == true) {
          visitedI.add(i);
        } else {
          yetToI.add(i);
        }
        datas.add(jsonEncode(value.data()));
        mids.add(value.data()!["mid"]);
        prices.add(value.data()!['price']);
      });
    }
    print(datas);
    for (int i = mids.length - 1; i >= 0; i--) {
      await store.collection("museums").doc(mids[i]).get().then((value) {
        muses.add(value.data()!["name"]);
      });
    }
    print(muses);
  }

  Widget _buildList({String key = "key", List? indexes}) {
    List<String> months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "Septemeber",
      "October",
      "November",
      "December"
    ];
    return ListView.builder(
      itemCount: indexes!.length,
      key: PageStorageKey(key),
      itemBuilder: (_, i) {
        final deets = jsonDecode(datas[indexes[i]]);
        DateTime d = DateTime.fromMicrosecondsSinceEpoch(deets['timestamp']);
        String date = d.day.toString() +
            " " +
            months[d.month] +
            " " +
            d.year.toString() +
            "\n" +
            deets["slotBooked"];
        return TicketCard(
            name: name,
            email: email,
            museumName: muses[indexes[i]],
            data: datas[indexes[i]],
            time: date,
            entrants: 5,
            souvenirs: 8,
            price: prices[indexes[i]],
            f: key == "key2");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getTicket().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: BilliAppBar(),
          body: Scaffold(
            appBar: AppBar(
              titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text("Tickets Booked"),
              bottom: TabBar(
                  labelColor: Palette.blue,
                  indicatorColor: Palette.blue,
                  tabs: [
                    Tab(text: "Upcoming Trips"),
                    Tab(text: "Previous Trips"),
                  ]),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildList(key: "key1", indexes: yetToI),
                  _buildList(key: "key2", indexes: visitedI),
                ],
              ),
            ),
          ),
        ));
  }
}
