import 'package:cart/componets/login_page_privacy.dart';
import 'package:cart/componets/sheet_login_input.dart';
import 'package:flutter/material.dart';
import 'package:cart/buttons/button_orange.dart';

class LoginActivity extends StatefulWidget {
  @override
  LoginActivityState createState() => LoginActivityState();
}

class LoginActivityState extends State<LoginActivity> {
  void _onLoginPressed() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => DraggableScrollableSheet(
          initialChildSize: 0.70,
          minChildSize: 0.0,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController){
            return SingleChildScrollView(
              controller: scrollController,
              child: const LoginInputBottomSheet(),
            );
          },

        ));
  }

  String user_phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/image/login_welcome_img.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black, size: 20),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'ACCOUNT',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Login/Create Account to manage orders',
                        style: TextStyle(fontSize: 12),
                      ),
                      CustomButton(
                        text: 'LOGIN',
                        height: 50,
                        borderRadius: 0.0,
                        onPressed: () {
                          _onLoginPressed();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const LoginPrivacyText(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.percent_sharp,
                                color: Colors.black54,
                                size: 16,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Offers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Colors.black26,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.black54,
                                size: 16,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Send Feedback',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'App version 1.0.0 (22)',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
