import 'package:cart/colors.dart';
import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.theme_light_gray,
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.search,
            color: AppColors.theme_black,
          ),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              cursorColor: AppColors.theme_black,
              decoration: InputDecoration(
                hintText: 'Search for dishes & restaurants',
                hintStyle: TextStyle(
                  color: AppColors.theme_gray,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'MonaSans',
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: AppColors.theme_black,
                fontWeight: FontWeight.w500,
                fontFamily: 'MonaSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
