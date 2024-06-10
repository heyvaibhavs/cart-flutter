import 'dart:developer';

import 'package:cart/buttons/button_orange.dart';
import 'package:cart/colors.dart';
import 'package:cart/componets/activity_home.dart';
import 'package:cart/componets/activity_signup.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPActivity extends StatefulWidget {
  final String phone;
  final bool isUser;
  const OTPActivity({super.key, required this.phone, required this.isUser});

  @override
  State<OTPActivity> createState() => _OTPActivityState();
}

class _OTPActivityState extends State<OTPActivity> {
  final TextEditingController _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _verificationId;
  int? resendToken;
  String _messageOTP = 'no message';
  late String phoneNumber =widget.phone;

  void _onOtpChanged() {
    setState(() {
      _isButtonEnabled = _otpController.text.length == 6;
    });
  }

  @override
  void initState() {
    phoneNumber = '+91${widget.phone}';
    _otpController.addListener(_onOtpChanged);
    _sendOtp();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.removeListener(_onOtpChanged);
    _otpController.dispose();
    super.dispose();
  }

  void _updateText(String text) {
    setState(() {
      _messageOTP = text;
    });
  }

  void _sendOtp() async {
    _updateText('Sending OTP...');
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credentials) {
          _updateText('Verification completed automatically');
        },
        verificationFailed: (FirebaseAuthException ex) {
          _updateText('Verification failed: ${ex.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            this.resendToken = resendToken;
          });
          _updateText('OTP Sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    }catch(ex){
      _updateText('Failed to send ${ex.toString()}');
    }
  }

  void _verifyOtp() async {

    final otp = _otpController.text;
    if (_verificationId == null) {
      _updateText('OTP has not been sent yet.');
      return;
    }
    try {
      _updateText('Verifying OTP...');
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        _updateText('OTP verified successfully');
        if(widget.isUser){
          SharedPreferences.getInstance().then((prefs) => prefs.setBool('isLogged', true));
          Navigator.push(context,
              SlidePageRoute(page: HomeActivity())
          );
        }else{
          Navigator.push(context,
              SlidePageRoute(page: SignUpActivity(phone: widget.phone))
          );
        }
      });
    } catch (ex) {
      _updateText('Failed to verify OTP: ${ex.toString()}');
      log(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.lightblue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'VERIFY DETAILS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            phoneNumber,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('ENTER OTP'),
                    TextFormField(
                      controller: _otpController,
                      autofocus: true,
                      cursorColor: AppColors.themeOrange,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      decoration: const InputDecoration(
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
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Didn't receive the OTP? Retry in 00:20",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      height: 50,
                      borderRadius: 5,
                      text: _isButtonEnabled ? 'CONTINUE' : 'ENTER OTP',
                      isEnabled: _isButtonEnabled,
                      onPressed: _isButtonEnabled ? _verifyOtp : null,
                    ),
                    Text(_messageOTP)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
