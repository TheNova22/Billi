// Todo: used 2 appbars ; might be bad practice ; figure out some other practice
import 'package:billi/configs/palette.dart';
import 'package:billi/modules/user_ticket_page/components/ticket_card.dart';
import 'package:billi/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UserTicketPage extends StatelessWidget {
  const UserTicketPage({Key? key}) : super(key: key);

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
                  _buildList(key: "key1", string: "List1: "),
                  _buildList(key: "key2", string: "List2: "),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget _buildList({String key = "key", String string = "list"}) {
  return ListView.builder(
    itemCount: 5,
    key: PageStorageKey(key),
    itemBuilder: (_, i) => TicketCard(),
  );
}
