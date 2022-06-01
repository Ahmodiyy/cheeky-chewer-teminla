import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool recipeLiked = false;
  bool recipeDisLiked = false;
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
                    height: 400,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 250,
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
                  ),
                  Positioned(
                    bottom: 5,
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
                            child: StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HighkonButton(
                                      iconBackgroundColor: recipeLiked
                                          ? constantActionColor
                                          : Colors.white,
                                      iconColor: recipeLiked
                                          ? Colors.white
                                          : constantActionColor,
                                      iconData: FontAwesomeIcons.thumbsUp,
                                      clickFunction: () {
                                        setState(() {
                                          print('llllllllll');
                                          recipeLiked = true;
                                          recipeDisLiked = false;
                                        });
                                      },
                                    ),
                                    constantHorizontalSizedBoxFifteen,
                                    HighkonButton(
                                      iconBackgroundColor: recipeDisLiked
                                          ? constantActionColor
                                          : Colors.white,
                                      iconColor: recipeDisLiked
                                          ? Colors.white
                                          : constantActionColor,
                                      iconData: FontAwesomeIcons.thumbsDown,
                                      clickFunction: () {
                                        setState(() {
                                          print('sssssssssssssss');
                                          recipeDisLiked = true;
                                          recipeLiked = false;
                                        });
                                      },
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: mainPadding + 5,
                ),
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            List.from(widget.document.data()['Ingredient'])
                                .length,
                        itemBuilder: (buildContent, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '. ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.document.data()['Ingredient'][index]}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            List.from(widget.document.data()['Instruction'])
                                .length,
                        itemBuilder: (buildContent, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index + 1}. '),
                              Expanded(
                                child: Text(
                                  '${widget.document.data()['Instruction'][index]}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    wordSpacing: 2,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
