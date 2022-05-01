import 'package:cheeky_chewer/components/shimmer_widget.dart';
import 'package:cheeky_chewer/models/recipe_data.dart';
import 'package:cheeky_chewer/screens/recipe_data_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/header_text_widget.dart';
import '../components/recipe_widget.dart';
import '../components/recent_recipe_widget.dart';
import '../utilities/constants.dart';

class Homepage extends StatefulWidget {
  static String id = 'homepage';
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double hoizontalListViewHeight = 200;
  late ScrollController scrollController;
  bool isScroll = true;
  bool isAppbarHeightReduce = false;
  double appbarHeight = 200;
  static const double sizedBoxHeight = 10;
  late Future<QuerySnapshot> recipeData;

  @override
  void initState() {
    super.initState();
    getData();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10) {
        print('we are at ${scrollController.position.pixels} pixels');
        setState(() {
          isScroll = false;
          hoizontalListViewHeight = 0;
        });
      } else {
        setState(() {
          isScroll = true;
          hoizontalListViewHeight = 200;
        });
      }
    });
  }

  void getData() {
    setState(() {
      recipeData = RecipeData.getRecipe(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appbarHeight +
              hoizontalListViewHeight), // here the desired height
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.bell,
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 15,
                          child: new Container(
                            height: 8,
                            width: 8,
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: KActionColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Text(
                              '',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.plusCircle,
                      ),
                      color: KActionColor,
                    ),
                  ],
                ),
                HeaderText(
                  headerTextString: 'What would you\nlike to cook?',
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                Visibility(
                  visible: isScroll,
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
                        return SizedBox(
                          height: hoizontalListViewHeight,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecentRecipe(
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
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 20,
                                );
                              },
                              itemCount: snapshot.data!.docs.length),
                        );
                      } else {
                        return SizedBox(
                          height: hoizontalListViewHeight,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ShimmerWidget.rectangular(
                                  width: 250,
                                  height: hoizontalListViewHeight,
                                  shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 20,
                                  ),
                              itemCount: 2),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                TextField(
                  readOnly: true,
                  onTap: () {
                    showSearch(
                      delegate: RecipeDataSearch(),
                      context: context,
                    );
                  },
                  decoration: KSearchDecoration,
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: recipeData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('something went wrong'),
                  );
                }
                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

                return StaggeredGridView.countBuilder(
                  controller: scrollController,
                  itemCount: docs.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (content, index) {
                    return Recipe(
                      recipeImageUrl:
                          docs.elementAt(index).data()['ImageUrl'].toString(),
                      recipeName:
                          docs.elementAt(index).data()['Name'].toString(),
                      recipeInfo:
                          docs.elementAt(index).data()['Info'].toString(),
                      recipePeriod:
                          docs.elementAt(index).data()['Duration'].toString(),
                      recipeRating:
                          docs.elementAt(index).data()['Rating'].toString(),
                      recipeCategory:
                          docs.elementAt(index).data()['Category'].toString(),
                    );
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.extent(1, (index % 3) == 0 ? 150 : 200),
                );
              } else {
                return StaggeredGridView.countBuilder(
                  controller: scrollController,
                  itemCount: 10,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (content, index) {
                    return ShimmerWidget.rectangular(
                      width: 250,
                      height: hoizontalListViewHeight,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.extent(1, (index % 3) == 0 ? 150 : 200),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
