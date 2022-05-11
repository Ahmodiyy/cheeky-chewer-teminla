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
  late Future<QuerySnapshot<Map<String, dynamic>>> recipeData;

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

  Future<QuerySnapshot<Map<String, dynamic>>> getSearchedRecipe(
      String queryString) async {
    return await RecipeData.getRecipeCollectionObject()
        .where('Name', isEqualTo: queryString)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
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
                decoration: constantSearchDecoration,
                onChanged: (value) {
                  setState(() {
                    recipeData = getSearchedRecipe(value);
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
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('something went wrong'),
                          );
                        }
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                            snapshot.data!.docs;
                        return StaggeredGridView.countBuilder(
                          itemCount: docs.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemBuilder: (content, index) {
                            return Recipe(
                              document: docs[index],
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
