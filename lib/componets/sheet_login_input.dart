import 'package:cart/componets/activity_home.dart';
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
import 'package:shared_preferences/shared_preferences.dart';



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
        bool isUser = data['user_exists'];
        if(isUser){
          SharedPreferences.getInstance().then((prefs) => prefs.setBool('isLogged', true));
          Navigator.push(
              context,
              SlidePageRoute(page: HomeActivity()) //add comment when live
            // SlidePageRoute(page: OTPActivity(phone: phone, isUser: isUser)) Remove comment when live
          );
        }else{
          Navigator.push(context,
              SlidePageRoute(page: OTPActivity(phone: phone, isUser: isUser))
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

