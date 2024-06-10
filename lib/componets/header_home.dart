import 'package:cart/colors.dart';
import 'package:cart/componets/activity_login.dart';
import 'package:cart/utilities/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        //main row
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deliver At',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'MonaSans',
                    fontWeight: FontWeight.normal,
                    color: AppColors.theme_gray),
              ),
              Row(
                children: [
                  Text(
                    'Hsr Layout',
                    style: TextStyle(
                        color: AppColors.theme_black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MonaSans'),
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.theme_green,)
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              SharedPreferences.getInstance().then((prefs) => prefs.setBool('isLogged', false));
              Navigator.pushReplacement(context, SlidePageRoute(page: LoginActivity()));
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://instagram.famd1-3.fna.fbcdn.net/v/t51.2885-19/447941741_472679305168992_6114592196080943377_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.famd1-3.fna.fbcdn.net&_nc_cat=100&_nc_ohc=nqsdz2ylHt0Q7kNvgG_YKmY&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYDbi2h922NvNrXfiGBZcS4OXjA93ePPgEXVyizZdSu5Ug&oe=666A7251&_nc_sid=8b3546'),
            ),
          )
        ],
      ),
    );
  }
}
