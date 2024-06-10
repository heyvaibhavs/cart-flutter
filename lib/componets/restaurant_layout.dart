import 'package:cart/colors.dart';
import 'package:cart/models/restro_data_model.dart';
import 'package:flutter/material.dart';

class RestaurantListLayout extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListLayout({required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(restaurant.image, fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10,
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.theme_light_gray,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border_outlined, color: Colors.black, size: 20),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'MonaSans',
                        fontSize: 18,
                        color: AppColors.theme_black,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      restaurant.cuisine,
                      style: TextStyle(
                        fontFamily: 'MonaSans',
                        color: AppColors.theme_gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.primary_yellow,),
                        Text(
                          restaurant.rating,
                          style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '1 Km | 22 Mins',
                      style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
