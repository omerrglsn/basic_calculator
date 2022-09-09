import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonOnTap,
  }) : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final void Function() buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonOnTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
