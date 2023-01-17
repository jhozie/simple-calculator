import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool toogle = false;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String displayText = '0';
  int numOne = 0;
  int numTwo = 0;
  String result = '';
  String operation = '';
  calculation(btnValue) {
    if (btnValue == 'C') {
      displayText = '';
      numOne = 0;
      numTwo = 0;
      result = '0';
      operation = '';
    } else if (btnValue == '+/-') {
      if (displayText.isEmpty) {
        result = '';
      } else if (displayText[0] != '-') {
        result = '-' + displayText.toString();
      } else {
        result = displayText.substring(1);
      }
    } else if (btnValue == '%') {
      if (displayText == '0') {
        result = '0';
      } else if (displayText.contains('.')) {
        result = '0';
      } else if (displayText.isNotEmpty) {
        double percent = 1 / 100 * int.parse(displayText);
        result = (percent.toString());
      }
    } else if (btnValue == '+' ||
        btnValue == '-' ||
        btnValue == '÷' ||
        btnValue == '×') {
      numOne = int.parse(displayText);
      result = '';
      operation = btnValue;
      // if (operation == '+') {
      //   result = (numOne + numTwo).toString();
      // }
      // if (operation == '-') {
      //   result = (numOne - numTwo).toString();
      // }
      // if (operation == '÷') {
      //   result = (numOne / numTwo).toString();
      // }

    } else if (btnValue == '×') {
      numTwo = int.parse(displayText);

      result = (numOne * numTwo).toString();
    } else if (btnValue == '=') {
      numTwo = int.parse(displayText);
      if (operation == '+') {
        result = (numOne + numTwo).toString();
      }
      if (operation == '-') {
        result = (numOne - numTwo).toString();
      }
      if (operation == '÷') {
        result = (numOne / numTwo).toString();
      }
      if (operation == '×') {
        result = (numOne * numTwo).toString();
      }
    } else if (btnValue == 'iconchange') {
      if (displayText.isEmpty) {
        result = '';
      } else {
        result = displayText.substring(0, displayText.length - 1);
      }
    } else if (btnValue == '.') {
      result = int.parse(displayText + '.').toString();
    } else {
      result = int.parse(displayText + btnValue).toString();
    }

    setState(() {
      displayText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toogle
          ? const Color.fromARGB(95, 46, 43, 59)
          : Color.fromARGB(244, 241, 245, 250),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlutterSwitch(
              // switchBorder: Border.all(
              //     width: 5, color: Color.fromARGB(217, 63, 112, 248)),
              inactiveToggleColor: Color.fromARGB(153, 199, 213, 252),
              inactiveColor: Colors.white,
              toggleColor: Colors.white54,
              padding: 6,
              width: 80,
              height: 50,
              toggleSize: 40,
              value: toogle,
              inactiveIcon: const Icon(
                Icons.light_mode_outlined,
                color: Color.fromARGB(217, 63, 112, 248),
              ),
              activeIcon: const Icon(
                Icons.dark_mode_outlined,
                color: Color.fromARGB(217, 63, 112, 248),
              ),
              activeColor: Color.fromARGB(253, 46, 43, 59),
              onToggle: ((value) {
                setState(() async {
                  toogle = !toogle;
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                });
              }),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: toogle ? Colors.white : Colors.black,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.black12,
                    text: 'C',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.black12,
                    text: '+/-',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.black12,
                    text: '%',
                    callback: calculation),
                MyButton(
                    textColor: Colors.white,
                    bgColor: const Color.fromARGB(217, 63, 112, 248),
                    text: '÷',
                    callback: calculation),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle
                        ? toogle
                            ? Colors.white10
                            : Colors.white
                        : Colors.white,
                    text: '7',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle
                        ? toogle
                            ? Colors.white10
                            : Colors.white
                        : Colors.white,
                    text: '8',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle
                        ? toogle
                            ? Colors.white10
                            : Colors.white
                        : Colors.white,
                    text: '9',
                    callback: calculation),
                MyButton(
                    textColor: Colors.white,
                    bgColor: const Color.fromARGB(217, 63, 112, 248),
                    text: '×',
                    callback: calculation),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle
                        ? toogle
                            ? Colors.white10
                            : Colors.white
                        : Colors.white,
                    text: '4',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.white,
                    text: '5',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.white,
                    text: '6',
                    callback: calculation),
                MyButton(
                    textColor: Colors.white,
                    bgColor: const Color.fromARGB(217, 63, 112, 248),
                    text: '-',
                    callback: calculation),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.white,
                    text: '1',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.white,
                    text: '2',
                    callback: calculation),
                MyButton(
                    textColor: toogle ? Colors.white : Colors.black,
                    bgColor: toogle ? Colors.white10 : Colors.white,
                    text: '3',
                    callback: calculation),
                MyButton(
                    textColor: Colors.white,
                    bgColor: const Color.fromARGB(217, 63, 112, 248),
                    text: '+',
                    callback: calculation),
              ],
            ),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              MyButton(
                  textColor: toogle ? Colors.white : Colors.black,
                  bgColor: toogle ? Colors.white10 : Colors.white,
                  text: '.',
                  callback: calculation),
              MyButton(
                  textColor: toogle ? Colors.white : Colors.black,
                  bgColor: toogle ? Colors.white10 : Colors.white,
                  text: '0',
                  callback: calculation),
              MyButton(
                iconData: Icons.backspace_outlined,
                textColor: toogle ? Colors.white : Colors.black,
                bgColor: toogle ? Colors.white10 : Colors.white,
                text: 'iconchange',
                callback: calculation,
              ),
              // BackIcon(
              //     callback: calculation,
              //     bgColor: toogle ? Colors.white10 : Colors.white,
              //     iconData: Icons.backspace_outlined),
              MyButton(
                iconData: Icons.backspace_outlined,
                textColor: Colors.white,
                bgColor: const Color.fromARGB(217, 63, 112, 248),
                text: '=',
                callback: calculation,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
