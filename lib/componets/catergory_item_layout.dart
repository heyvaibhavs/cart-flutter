import 'package:cart/colors.dart';
import 'package:flutter/material.dart';

class CategoryItemLayout extends StatefulWidget {
  final String categoryName;
  final String categorySubName;
  const CategoryItemLayout({super.key, required this.categoryName, required this.categorySubName});

  @override
  State<CategoryItemLayout> createState() => _CategoryItemLayoutState();
}

class _CategoryItemLayoutState extends State<CategoryItemLayout> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.theme_light_gray,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //set CategoryName here
          Text(widget.categoryName, style: TextStyle(
            fontFamily: 'MonaSans',
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),),
          //set SubCategory name here
          Text(widget.categorySubName, style: TextStyle(
            fontFamily: 'MonaSans',
            fontSize: 12
          ),)
        ],
      ),
    );
  }
}

class CategoryLayout extends StatefulWidget{
  const CategoryLayout({super.key});

  @override
  State<CategoryLayout> createState() => _CategoryLayoutState();
}

class _CategoryLayoutState extends State<CategoryLayout>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryItemLayout(categoryName: 'Pizza', categorySubName: '25 mins',),
              CategoryItemLayout(categoryName: 'Momos', categorySubName: '25 mins',),
              CategoryItemLayout(categoryName: 'Biryani', categorySubName: '25 mins',),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryItemLayout(categoryName: 'Burger', categorySubName: '25 mins',),
              CategoryItemLayout(categoryName: 'Paneer', categorySubName: '25 mins',),
              CategoryItemLayout(categoryName: 'Sandwich', categorySubName: '25 mins',),
            ],
          ),
        ],
      ),
    );
  }
}
