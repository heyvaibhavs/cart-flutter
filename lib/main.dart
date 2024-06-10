import 'package:cart/componets/activity_home.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:cart/componets/activity_signup.dart';
import 'package:cart/componets/activity_splash.dart';
import 'package:cart/componets/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase App: initialized successfully');
  } catch (e) {
    print('Firebase App: Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Color themeOrange = Colors.white30;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeOrange, // Set the status bar color
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:SplashActivity(),
        ),
      );
  }
}

