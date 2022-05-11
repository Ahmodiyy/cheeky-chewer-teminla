import 'package:cheeky_chewer/components/rating_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';
import 'ingredient_widget.dart';

class RecentRecipe extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  const RecentRecipe({
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
                child: Text(
                  document.data()['Info'].toString(),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 20,
              child: Text(
                document.data()['Name'].toString(),
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
                      '  ${document.data()['Duration'].toString()} . ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      document.data()['Category'].toString(),
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
              child: RatingWidget(
                rating: document.data()['Rating'].toString(),
              ),
            ),
          ],
        ),
        width: 250,
        height: 200,
        decoration: ShapeDecoration(
          color: Colors.white,
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
    );
  }
}
