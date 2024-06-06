import 'package:cart/colors.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to home page", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeOrange
              ),),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, LoginActivity());
              },style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeOrange
              ),
                  child: Text('LOGOUT')
              )
            ],
          ),
        )
      )),
    );
  }
}
