import 'package:cart/componets/activity_otp.dart';
import 'package:cart/componets/homepage.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cart/buttons/button_orange.dart';
import 'package:cart/componets/login_page_privacy.dart';
import 'package:cart/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:cookie_jar/cookie_jar.dart';



class LoginInputBottomSheet extends StatefulWidget {
  const LoginInputBottomSheet({super.key});

  @override
  _LoginInputBottomSheetState createState() => _LoginInputBottomSheetState();
}

class _LoginInputBottomSheetState extends State<LoginInputBottomSheet> {

  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _userExists = false;


  void _onPhoneChanged() {
    setState(() {
      _isButtonEnabled = _phoneController.text.length == 10;
    });
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onUserVerification() async {
    final phone = _phoneController.text;
    final url = Uri.parse('https://flutterapp.rapidread.in/user_verification.php?phone=$phone');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['user_exists']) {
          // User exists, navigate to the OTPActivity page
          Navigator.push(
            context,
            SlidePageRoute(page: OTPActivity(phone: phone,))
          );
        } else {
          // User does not exist, show a Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User does not exist')),
          );
        }
      } else {
        // Handle the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify user')),
        );
      }
    } catch (e) {
      developer.log('Error during user verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during user verification')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("Enter phone number to proceed",
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _phoneController,
              autofocus: true,
              cursorColor: AppColors.themeOrange,
              keyboardType: TextInputType.phone,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              decoration: const InputDecoration(
                prefixText: '+91',
                labelText: '10 digit mobile number',
                floatingLabelStyle: TextStyle(color: Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themeOrange,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themeOrange,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themeOrange,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themeOrange,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              // autofillHints: const [AutofillHints.telephoneNumber], // Added autofill hint
            ),
            const SizedBox(height: 30),
            CustomButton(
              height: 50,
              borderRadius: 5,
              text: 'CONTINUE',
              isEnabled: _isButtonEnabled,
              onPressed: _isButtonEnabled ? _onUserVerification  : null,
                //on press call generate csrf token api and if token is not null call check user api, if user exist navigate to another page
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) => OTPActivity(),
                //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                //       const begin = Offset(1.0, 0.0);
                //       const end = Offset.zero;
                //       const curve = Curves.easeInOut;
                //
                //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                //       var offsetAnimation = animation.drive(tween);
                //
                //       return SlideTransition(
                //         position: offsetAnimation,
                //         child: child,
                //       );
                //     },
                //   ),
                // );

            ),
            const SizedBox(
              height: 15,
            ),
            const LoginPrivacyText(),
          ],
        ),
      ),
    );
  }
}

