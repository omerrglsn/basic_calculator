import 'package:calculator/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> userInput = ValueNotifier<String>('');
    ValueNotifier<String> userOutput = ValueNotifier<String>('');

    List<String> buttons =
        (['C', 'DEL', '%', '/', '7', '8', '9', 'x', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', 'ANS', '=']);

    void equalPressed() {
      String finalQuestion = userInput.value;
      finalQuestion = finalQuestion.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userOutput.value = eval.toString();
    }

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: userInput,
                    builder: (context, value, child) {
                      return Text(
                        userInput.value,
                        style: const TextStyle(fontSize: 40),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: userOutput,
                    builder: (context, value, child) {
                      return Text(
                        userOutput.value,
                        style: const TextStyle(fontSize: 30),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CustomButton(
                    buttonColor: Colors.green,
                    buttonText: buttons[index],
                    buttonOnTap: () {
                      userInput.value = '';
                      userOutput.value = '';
                    },
                  );
                } else if (index == 1) {
                  return CustomButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.green,
                    buttonOnTap: () {
                      if (userInput.value.isNotEmpty) {
                        userInput.value = userInput.value.substring(0, userInput.value.length - 1);
                      }
                    },
                  );
                } else if (index == buttons.length - 1) {
                  return CustomButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.green,
                    buttonOnTap: () {
                      if (userInput.value.isNotEmpty) {
                        equalPressed();
                      }
                    },
                  );
                } else {
                  return CustomButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.green,
                    buttonOnTap: () {
                      userInput.value += buttons[index];
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
