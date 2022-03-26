// ignore_for_file: prefer_const_constructors

import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.title,
      required this.onTap})
      : super(key: key);
  final double width;
  final double height;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Palette.blue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextButton(
            onPressed: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: Palette.white,

                  fontFamily: 'Lato',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )));
  }
}
