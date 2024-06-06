import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color themeOrange = Color(0xFFFA6E20);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60, // Set the height of the custom app bar
              color: themeOrange, // Set the background color of the custom app bar
              child: Row(
                children: [
                  Image.asset('assets/image/ig_logo.png'),
                  Text(
                    'DECART',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  //add icon here
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      // Add your search functionality here
                    },
                    icon: Icon(Icons.search_rounded, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add your search functionality here
                    },
                    icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
