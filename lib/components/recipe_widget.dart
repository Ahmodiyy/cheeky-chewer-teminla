import 'package:cheeky_chewer/components/rating_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'ingredient_widget.dart';

class Recipe extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  const Recipe({
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Ingredient(document);
            });
      },
      child: Container(
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
                    document.data()['ImageUrl'].toString(),
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
                  document.data()['Duration'].toString(),
                  style: constantStyleRecipeDurationAndCategory,
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
                  document.data()['Category'].toString(),
                  style: constantStyleRecipeDurationAndCategory,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 10,
              child: RatingWidget(
                rating: document.data()['Rating'].toString(),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 20,
              child: FittedBox(
                child: Text(
                  document.data()['Name'].toString(),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 5,
              child: FittedBox(
                child: Text(
                  document.data()['Type'].toString(),
                  style: constantStyleRecipeType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
