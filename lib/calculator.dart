import 'package:calculator_app1/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  MyButton({
    required this.bgColor,
    required this.text,
    this.callback,
    required this.textColor,
    this.iconData,
  });

  final String text;
  Color bgColor;
  final Function? callback;
  Color textColor;
  IconData? iconData;

  final iconIf = 'iconchange';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback!(text);
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: const Size(75, 70),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: bgColor),
      child: text == iconIf
          ? Icon(
              iconData,
              color: toogle ? Colors.white : Colors.black,
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
    );
  }
}
