import 'package:flutter/material.dart';

class LoginPrivacyText extends StatefulWidget {
  const LoginPrivacyText({super.key});

  @override
  State<LoginPrivacyText> createState() => _LoginPrivacyTextState();
}

class _LoginPrivacyTextState extends State<LoginPrivacyText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(
          text: 'By clicking, I accept the ',
          style: TextStyle(fontSize: 12),
          children: <TextSpan>[
            TextSpan(
                text: 'Terms & Conditions ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )),
            TextSpan(
                text: 'and ', style: TextStyle(fontSize: 12)),
            TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ))
          ])),
    );
  }
}
