import 'package:billi/configs/palette.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

Widget CommonBottomNavigationBar(int page)
{
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  return  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: page,
            height: 60.0,
            items:const <Widget>[
              Icon(Icons.home_filled,color: Palette.white, size: 30),
              Icon(Icons.wallet_travel,color: Palette.white, size: 30),
              Icon(Icons.account_circle_sharp, color: Palette.white, size: 30),
            ],
            color: Palette.blue,
            buttonBackgroundColor: Palette.blue,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
                page = index;
            },
            letIndexChange: (index) => true,
          );
}

