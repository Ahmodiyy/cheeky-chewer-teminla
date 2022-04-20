import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/functions.dart';

class RecipeData {
  static FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getRecipe(BuildContext context) async {
    QuerySnapshot querySnapshot =
        await _cloudStore.collection('Recipe').get().catchError((e) {
      showErrorMsg(context, e.toString());
    });
    return querySnapshot;
  }
}
