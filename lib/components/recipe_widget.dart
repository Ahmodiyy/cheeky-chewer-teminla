import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';

class Recipe extends StatelessWidget {
  final String recipeImageUrl;
  final String recipeName;
  final String recipeInfo;
  final String recipePeriod;
  final String recipeRating;
  final String recipeCategory;
  const Recipe({
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
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 40),
            decoration: ShapeDecoration(
              color: Colors.grey.shade400,
              image: DecorationImage(
                image: NetworkImage(
                  recipeImageUrl,
                ),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xff757572),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                recipePeriod,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xff757572),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                recipeCategory,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
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
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: FittedBox(
              child: Text(recipeName),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 5,
            child: FittedBox(
              child: Text(
                recipeCategory,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xffCBC5BC),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
