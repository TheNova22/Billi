import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.hint,
      required this.suffixWidget,
      required this.width,
      required this.height,
      this.inputType = TextInputType.text,
      this.maxLines = 1,
      this.fontSize = 15,
      this.hideText = false})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hint;
  final Widget? suffixWidget;
  final double width;
  final double height;
  final TextInputType inputType;
  final bool hideText;
  final int? maxLines;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Palette.black,
                    fontFamily: 'Lato',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ],
          ),
          Container(
            width: width,
            height: height - 20,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Palette.white,
              border: Border.all(
                color: const Color.fromRGBO(189, 189, 189, 1),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              maxLines: maxLines,
              obscureText: hideText,
              style: TextStyle(fontSize: fontSize),
              cursorColor: const Color.fromARGB(255, 83, 82, 82),
              decoration: InputDecoration(
                  hintText: hint,
                  suffixIcon: suffixWidget,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
          )
        ],
      ),
    );
  }
}
