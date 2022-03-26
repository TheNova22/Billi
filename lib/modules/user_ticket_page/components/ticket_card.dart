// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:billi/configs/palette.dart';
import 'package:billi/widgets/show_ticket.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    Key? key,
    this.name = "Robert Samuel",
    this.email = "robertsamuel@gmail.com",
    this.museumName = "Supreme Museum",
    this.data = "12345",
    this.time = "25th August 2073 | 9AM - 1PM",
    this.entrants = 5,
    this.souvenirs = 8,
    this.price = 750,
    this.warning =
        "The entry into the museum shall happen when all the entrants are present",
  }) : super(key: key);

  final String name;
  final String email;
  final String museumName;
  final String data;
  final String time;
  final int entrants;
  final int souvenirs;
  final int price;
  final String warning;
  @override
  Widget build(BuildContext context) {
    void callCard() {
      showTicket(context, name, email, museumName, data, time, entrants,
          souvenirs, warning);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: callCard,
        child: Container(
          height: 230,
          margin: EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(115, 107, 107, 107),
                  offset: const Offset(
                    0,
                    5,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    "https://www.albawaba.com/sites/default/files/styles/default/public/2020-04/shutterstock_482978608.jpg?itok=eS77PfeY",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 12, right: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(museumName,
                                      style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                  Text("Central Road, Central Asia, Bagalore",
                                      style: TextStyle(fontSize: 11.5)),
                                ]),
                            Text(
                                entrants.toString() +
                                    " entrants | " +
                                    souvenirs.toString() +
                                    " souvenirs",
                                style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(time,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                minFontSize: 11,
                                maxFontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.black.withOpacity(0.6))),
                            AutoSizeText("₹ " + price.toString(),
                                maxLines: 1,
                                minFontSize: 12,
                                maxFontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.black.withOpacity(0.6))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
