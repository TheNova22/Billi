// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:auto_size_text/auto_size_text.dart';
import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;

void showTicket(
    BuildContext context,
    String name,
    String email,
    String museumName,
    String data,
    String time,
    int entrants,
    int souvenirs,
    String warning) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              width: 320,
              height: 550,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.museum_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          museumName,
                          minFontSize: 18,
                          maxFontSize: 22,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Palette.gold,
                              fontSize: 22,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: data,
                    version: QrVersions.auto,
                    size: 190.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                            Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: CustomPaint(
                                painter: MyPainter(),
                                size: Size(20, 20),
                              ),
                            ),
                          ] +
                          List.generate(
                              31,
                              (index) => Expanded(
                                    child: Container(
                                        height: 2,
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Palette.black),
                                  )) +
                          [
                            Transform.rotate(
                              angle: -90 * math.pi / 180,
                              child: CustomPaint(
                                painter: MyPainter(),
                                size: Size(20, 20),
                              ),
                            ),
                          ]),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(name,
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Palette.black.withOpacity(0.6))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(email,
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            color: Palette.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(time,
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Palette.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(entrants.toString() + " entrants",
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            color: Palette.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(souvenirs.toString() + " souvenirs",
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            color: Palette.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: AutoSizeText(warning,
                        minFontSize: 11,
                        maxFontSize: 14,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Palette.black)),
                  ),
                ],
              ),
            ),
          ));
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xffDFDFDF);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
