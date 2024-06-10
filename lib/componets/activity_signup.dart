import 'dart:developer';

import 'package:cart/buttons/button_orange.dart';
import 'package:cart/colors.dart';
import 'package:cart/componets/activity_home.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:cart/utilities/text_field.dart';
import 'package:cart/utilities/whatsapp_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class SignUpActivity extends StatefulWidget {
  final String phone;
  const SignUpActivity({super.key, required this.phone});

  @override
  State<SignUpActivity> createState() => _SignUpActivityState();
}

class _SignUpActivityState extends State<SignUpActivity> {
  final WhatsAppService _whatsAppService = WhatsAppService();
  bool _isChecked = false;
  final TextEditingController _controller_first_name = TextEditingController();
  final TextEditingController _controller_last_name = TextEditingController();
  final TextEditingController _controller_email = TextEditingController();
  bool _isButtonEnabled = false;
  String? _phone;
  bool _isLoading = false;
  late String _message;


  void _onEmailChanged() {
    setState(() {
      _isButtonEnabled = _controller_email.text.contains('@') && _isChecked;
    });
  }

  @override
  void initState() {
    _controller_email.addListener(_onEmailChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller_email.removeListener(_onEmailChanged);
    _controller_first_name.dispose();
    _controller_last_name.dispose();
    _controller_email.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final phone = '+918877542303';
    final otp = '123456'; // Generate or fetch your OTP
    _whatsAppService.sendOtpMessage(phone, otp);
  }

  Future<void> _createAccount() async {
    setState(() {
      _isLoading = true;
    });
    final phone = widget.phone;
    final firstName = _controller_first_name.text; // Add this line
    final lastName = _controller_last_name.text; // Add this line
    final email = _controller_email.text; // Add this line
    final url = Uri.parse(
        'https://flutterapp.rapidread.in/user_create_account.php?name=$firstName&last_name=$lastName&phone=$phone&email=$email');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          _message = jsonResponse['message'];
          SharedPreferences.getInstance().then((prefs) => prefs.setBool('isLogged', true));
        } else {
          _message = jsonResponse['message'];
        }
        Navigator.push(context, SlidePageRoute(page: HomeActivity()));
      } else {
        // Handle the error
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create account')),
        );
      }
    } catch (e) {
      _isLoading =false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Signp $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Your Profile',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("We promise not to spam your email."),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    SlidePageRoute(page: LoginActivity()));
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 25,
                              )),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'First name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      CustomPhoneTextField(
                        controller: _controller_first_name,
                        focusedBorderColor: Colors.black54,
                        enabledBorderColor: Colors.black26,
                        focusedErrorBorderColor: AppColors.themeOrange,
                        errorBorderColor: AppColors.themeOrange,
                        borderRadius: BorderRadius.circular(8),
                        autofocus: false,
                        hintText: 'First name',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Last name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      CustomPhoneTextField(
                        controller: _controller_last_name,
                        focusedBorderColor: Colors.black54,
                        enabledBorderColor: Colors.black26,
                        focusedErrorBorderColor: AppColors.themeOrange,
                        errorBorderColor: AppColors.themeOrange,
                        borderRadius: BorderRadius.circular(8),
                        autofocus: false,
                        hintText: 'Last name',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Email ID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      CustomPhoneTextField(
                        controller: _controller_email,
                        focusedBorderColor: Colors.black54,
                        enabledBorderColor: Colors.black26,
                        focusedErrorBorderColor: AppColors.themeOrange,
                        errorBorderColor: AppColors.themeOrange,
                        borderRadius: BorderRadius.circular(8),
                        autofocus: false,
                        hintText: 'you@example.com',
                        textInputType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Our ',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.themeOrange,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Privacy Policy page
                              },
                          ),
                          TextSpan(
                            text:
                                ' outlines what personal data we collect, why we collect it, and how we use it. Our ',
                          ),
                          TextSpan(
                            text: 'Conditions of Use',
                            style: TextStyle(
                              color: AppColors.themeOrange,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Conditions of Use page
                              },
                          ),
                          TextSpan(
                            text:
                                ' govern your access and use of this application.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: AppColors.themeOrange,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                        _isButtonEnabled =
                            _controller_email.text.contains('@') && _isChecked;
                      });
                    },
                    title: Text(
                      'I have read and I accept the Privacy Policy and Conditions of Use',
                      style: TextStyle(fontSize: 12),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _isLoading
                        ? CircularProgressIndicator() : CustomButton(
                      height: 50,
                      borderRadius: 5,
                      text: 'CREATE ACCOUNT',
                      isEnabled: _isButtonEnabled,
                      onPressed: _isButtonEnabled ? _createAccount : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
