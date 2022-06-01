import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:cheeky_chewer/components/rating_widget.dart';
import 'package:cheeky_chewer/screens/recipe_instruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/functions.dart';

class Ingredient extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  const Ingredient(
    final this.document,
  );

  final double modalBottomSheetColumnPadding = 30;
  final double ingredientColumnPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: modalBottomSheetColumnPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
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
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RatingWidget(
                                  rating: document.data()['Rating'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                returningRecipeInfoWidget(
                                  document.data()['Info'].toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: FittedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document.data()['Name'].toString(),
                                      style:
                                          constantStyleRecipeNameForIngredient,
                                    ),
                                    Text(
                                      document.data()['Type'].toString(),
                                      style:
                                          constantStyleRecipeTypeForIngredient,
                                    ),
                                    Text(
                                      '${document.data()['Category'].toString()} . ${document.data()['Duration'].toString()}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              constantIngredientWhiteHorizontalSpacing,
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF8BC5E),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ingredientColumnPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'Ingredients',
                            style: constantIngredientTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Container(
                              child: Scrollbar(
                                thickness: 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      List.from(document.data()['Ingredient'])
                                          .length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '.  ${document.data()['Ingredient'][index].toString()} ',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              constantIngredientWhiteHorizontalSpacing,
              ActionButton(
                  actionString: 'ViewRecipe',
                  action: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RecipeInstruction(document),
                        ),
                      ),
                  dontHideActionText: true),
              constantIngredientWhiteHorizontalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
