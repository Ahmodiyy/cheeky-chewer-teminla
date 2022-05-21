import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/highkon_button.dart';
import '../components/rating_widget.dart';
import '../utilities/constants.dart';
import '../utilities/functions.dart';

class RecipeInstruction extends StatefulWidget {
  static String id = 'recipeinstruction';
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  const RecipeInstruction(
    final this.document,
  );

  @override
  State<RecipeInstruction> createState() => _RecipeInstructionState();
}

class _RecipeInstructionState extends State<RecipeInstruction> {
  final double mainPadding = 20;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: constantAppColorTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Recipe Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.document.data()['ImageUrl'].toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 210,
                    left: mainPadding,
                    right: mainPadding,
                    child: Container(
                      padding: EdgeInsets.all(mainPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    returningRecipeInfoWidget(
                                      widget.document.data()['Info'].toString(),
                                    ),
                                    RatingWidget(
                                      rating: widget.document
                                          .data()['Rating']
                                          .toString(),
                                    ),
                                  ],
                                ),
                                constantHorizontalSizedBoxTen,
                                Text(
                                  widget.document.data()['Name'].toString(),
                                  style: constantStyleRecipeNameForIngredient,
                                ),
                                Text(
                                  widget.document.data()['Type'].toString(),
                                  style: constantStyleRecipeTypeForIngredient,
                                ),
                                Text(
                                  '${widget.document.data()['Category'].toString()} . ${widget.document.data()['Duration'].toString()}',
                                ),
                                constantHorizontalSizedBoxTen,
                                Text(
                                  'Tags',
                                  style: constantStyleRecipeNameForIngredient,
                                ),
                                Text(
                                  widget.document.data()['Type'].toString(),
                                  style: constantStyleRecipeTypeForIngredient,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                HighkonButton(
                                  iconData: FontAwesomeIcons.thumbsUp,
                                  clickFunction: () {},
                                ),
                                constantHorizontalSizedBoxFifteen,
                                HighkonButton(
                                  iconData: FontAwesomeIcons.thumbsDown,
                                  clickFunction: () {},
                                ),
                                constantHorizontalSizedBoxFifteen,
                                HighkonButton(
                                  iconContainerSize: 42,
                                  iconBackgroundColor: constantActionColor,
                                  iconColor: Colors.white,
                                  iconData: FontAwesomeIcons.shareAlt,
                                  clickFunction: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 180,
                ),
                padding: EdgeInsets.symmetric(horizontal: mainPadding + 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients',
                      style: constantIngredientTextStyle,
                    ),
                    constantHorizontalSizedBoxTen,
                    Padding(
                      padding: EdgeInsets.only(left: mainPadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: returningListTextWidgets(
                          List.from(widget.document.data()['Ingredient'])
                              .length,
                          List.from(widget.document.data()['Ingredient']),
                          false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Instructions',
                      style: constantIngredientTextStyle,
                    ),
                    constantHorizontalSizedBoxTen,
                    Padding(
                      padding: EdgeInsets.only(left: mainPadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: returningListTextWidgets(
                          List.from(widget.document.data()['Instruction'])
                              .length,
                          List.from(widget.document.data()['Instruction']),
                          true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
