import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/functions.dart';

class RecipeData {
  static FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getRecipeCollection(
      BuildContext context) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _cloudStore.collection('Recipe').get().catchError((e) {
      showErrorMsg(context, e.toString());
    });
    return querySnapshot;
  }

  getRecipeForSearch(BuildContext context) async {
    //await _cloudStore.collection('Recipe').get().
  }
}
