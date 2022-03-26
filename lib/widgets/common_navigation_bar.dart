import 'package:billi/configs/palette.dart';
import 'package:billi/modules/user_home_page/user_home_page.dart';
import 'package:billi/modules/user_log_in_page/user_log_in_page.dart';
import 'package:billi/modules/user_ticket_page/user_ticket.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

Widget CommonBottomNavigationBar(int page, BuildContext context) {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  return CurvedNavigationBar(
    key: _bottomNavigationKey,
    index: page,
    height: 60.0,
    items: const <Widget>[
      Icon(Icons.home_filled, color: Palette.white, size: 30),
      Icon(Icons.wallet_travel, color: Palette.white, size: 30),
      Icon(Icons.account_circle_sharp, color: Palette.white, size: 30),
    ],
    color: Palette.blue,
    buttonBackgroundColor: Palette.blue,
    backgroundColor: Colors.white,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 600),
    onTap: (index) {
      page = index;
      switch (index) {
        case 0:
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => UserHome()));
          break;
        case 1:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => UserTicketPage()));
      }
    },
    letIndexChange: (index) => true,
  );
}
