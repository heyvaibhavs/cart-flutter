import 'package:cart/colors.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:cart/componets/activity_splash.dart';
import 'package:cart/componets/catergory_item_layout.dart';
import 'package:cart/componets/header_home.dart';
import 'package:cart/componets/restaurant_layout.dart';
import 'package:cart/componets/search_bar.dart';
import 'package:cart/models/restro_data_model.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  late Future<List<Restaurant>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    futureRestaurants = fetchRestaurants();
  }

  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse('https://flutterapp.rapidread.in/restro_list.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Restaurant.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Set the status bar color
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  SizedBox(
                    height: 20,
                  ),
                  SearchBarApp(),
                  SizedBox(height: 10,),
                  Expanded(
                    child: FutureBuilder<List<Restaurant>>(
                      future: futureRestaurants,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Restaurant> restaurants = snapshot.data!;
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CategoryLayout(),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset('assets/image/banner6.png', fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Top Rated Restaurants',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MonaSans',
                                    color: AppColors.theme_black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: restaurants.map((restaurant) {
                                    return RestaurantListLayout(restaurant: restaurant);
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

