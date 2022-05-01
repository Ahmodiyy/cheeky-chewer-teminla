import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class RecipeDataSearch extends SearchDelegate {
  RecipeDataSearch()
      : super(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            isDense: true,
            fillColor: KSearchColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KSearchColor, width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KSearchColor, width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
          ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(primaryColor: KSearchColor, backgroundColor: KSearchColor);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('jkfkkfkfdfks');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text('jkfkkfkfdfks');
  }
}
