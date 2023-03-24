import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstnumber = 0.0;
  double secondnumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  onButtonClick(text) {
    // AC
    if (text == "AC") {
      input = '';
      output = '';
    } else if (text == "CE") {
      input = '';
    } else if (text == "D") {
      input = input.substring(0, input.length - 1);
    } else if (text == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      }
    } else {
      input = input + text;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Calculator App',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.black26,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  color: Colors.red,
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(text: "AC", butcol: Colors.green),
              button(text: "D", butcol: Colors.blue),
              button(text: "R", butcol: Colors.blue),
              button(text: "CE", butcol: Colors.deepOrange)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "/", butcol: Colors.deepOrange)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "x", butcol: Colors.deepOrange)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", butcol: Colors.deepOrange)
            ],
          ),
          Row(
            children: [
              button(text: "."),
              button(text: "0"),
              button(text: "=", butcol: Colors.green),
              button(text: "-", butcol: Colors.deepOrange)
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget button({text, tcol = Colors.black, butcol = Colors.white}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: butcol,
              padding: const EdgeInsets.all(18)),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 28, color: tcol, fontWeight: FontWeight.bold),
          )),
    ));
  }
}
