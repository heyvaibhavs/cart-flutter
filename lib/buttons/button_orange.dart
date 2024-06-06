import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double borderRadius;
  final double height;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.borderRadius = 5.0,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    Color enabledColor = Color(0xFFE46C47);
    Color disabledColor = Colors.grey;

    return Column(
      children: [
        SizedBox(width: 5, height: 15),
        Container(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? enabledColor : disabledColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            onPressed: isEnabled ? onPressed : null,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
