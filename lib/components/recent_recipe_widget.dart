import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';

class RecentRecipe extends StatelessWidget {
  final String recipeImageUrl;
  final String recipeName;
  final String recipeInfo;
  final String recipePeriod;
  final String recipeRating;
  final String recipeCategory;
  const RecentRecipe({
    required this.recipeImageUrl,
    required this.recipeName,
    required this.recipeInfo,
    required this.recipePeriod,
    required this.recipeRating,
    required this.recipeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xffF7EEE3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(recipeInfo),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 20,
            child: Text(
              recipeName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
              bottom: 40,
              left: 20,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    size: 12,
                    color: Colors.white,
                  ),
                  Text(
                    '  $recipePeriod . ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    recipeCategory,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )
                ],
              )),
          Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: KActionColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Icon(
                      FontAwesomeIcons.star,
                      color: Colors.black,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      recipeRating,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      width: 250,
      height: 200,
      decoration: ShapeDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(recipeImageUrl),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
