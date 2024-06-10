import 'dart:async';

import 'package:cart/colors.dart';
import 'package:cart/componets/activity_home.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashActivity extends StatefulWidget {
  const SplashActivity({super.key});

  @override
  State<SplashActivity> createState() => _SplashActivityState();
}


class _SplashActivityState extends State<SplashActivity> {

  @override
  void initState(){
    super.initState();
    
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLogged = prefs.getBool('isLogged') ?? false;
      if(isLogged){
        Navigator.pushReplacement(context,
            SlidePageRoute(page: HomeActivity())
        );
      }else{
        Navigator.pushReplacement(context,
            SlidePageRoute(page: LoginActivity())
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.themeOrange,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Freeat', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.white
            ),)
          ],
        ),
      ),
    );
  }
}
