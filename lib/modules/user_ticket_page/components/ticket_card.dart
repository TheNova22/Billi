import 'package:billi/widgets/show_ticket.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = "Robert Samuel";
    String email = "robertsamuel@gmail.com";
    String museumName = "Supreme Museum";
    String data = "12345";
    String time = "25th August 2073 | 9AM - 1PM";
    int entrants = 5;
    int souvenirs = 8;
    String warning =
        "The entry into the museum shall happen when all the entrants are present";
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
                                  Text("Supreme Museum",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text("Central Road, Central Asia, Bagalore",
                                      style: TextStyle(fontSize: 11.5)),
                                ]),
                            Text("5 entrants | 6 souvenirs",
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
                            Column(children: [
                              Text("25 Aug 2022",
                                  style: TextStyle(fontSize: 12)),
                              Text("9 AM - 1 PM",
                                  style: TextStyle(fontSize: 12)),
                            ]),
                            Text("750", style: TextStyle(fontSize: 13))
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
