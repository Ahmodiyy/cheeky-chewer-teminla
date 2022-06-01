import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/functions.dart';

class RecipeData extends ChangeNotifier {
  static const double likeReduction = -1;
  static const double likeAddition = 1;
  static FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getRecipeCollection(
      BuildContext context) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _cloudStore.collection('Recipe').get().catchError((e) {
      showErrorMsg(context, e.toString());
    });

    return querySnapshot;
  }

  static CollectionReference<Map<String, dynamic>> getRecipeCollectionObject() {
    return _cloudStore.collection('Recipe');
  }

  static likeOrDislikeRecipe(
      bool like, QueryDocumentSnapshot<Map<String, dynamic>> document) async {
    double recipeLikeReduction = double.parse(((getRecipeDocument(document))
                as DocumentSnapshot<Map<String, dynamic>>)
            .data()!['Rating']
            .toString()) -
        likeReduction;

    _cloudStore
        .collection('collectionPath')
        .doc(document.id)
        .update({'Rating': recipeLikeReduction.toString()});
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getRecipeDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) async {
    return await _cloudStore.collection('Recipe').doc(document.id).get();
  }
}
