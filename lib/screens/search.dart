import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/recipe_widget.dart';
import '../models/recipe_data.dart';
import '../utilities/constants.dart';

class Search extends StatefulWidget {
  static String id = 'search';
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<QuerySnapshot> recipeData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    setState(() {
      recipeData = RecipeData.getRecipeCollection(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Search Page',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ))),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                autofocus: true,
                decoration: KSearchDecoration,
                onChanged: (value) {
                  setState(() {
                    recipeData.asStream().map((event) => event.docs.where(
                        (element) =>
                            element.data()['Name'].toString().contains(value)));
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('found 16 results'),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: recipeData,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('something went wrong'),
                          );
                        }
                        List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

                        return StaggeredGridView.countBuilder(
                          itemCount: docs.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemBuilder: (content, index) {
                            return Recipe(
                              recipeImageUrl: docs
                                  .elementAt(index)
                                  .data()['ImageUrl']
                                  .toString(),
                              recipeName: docs
                                  .elementAt(index)
                                  .data()['Name']
                                  .toString(),
                              recipeInfo: docs
                                  .elementAt(index)
                                  .data()['Info']
                                  .toString(),
                              recipePeriod: docs
                                  .elementAt(index)
                                  .data()['Duration']
                                  .toString(),
                              recipeRating: docs
                                  .elementAt(index)
                                  .data()['Rating']
                                  .toString(),
                              recipeCategory: docs
                                  .elementAt(index)
                                  .data()['Category']
                                  .toString(),
                            );
                          },
                          staggeredTileBuilder: (index) => StaggeredTile.extent(
                              1, (index % 3) == 0 ? 150 : 200),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
