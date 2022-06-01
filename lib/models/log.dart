import 'package:cheeky_chewer/screens/homepage.dart';
import 'package:cheeky_chewer/screens/info.dart';
import 'package:cheeky_chewer/screens/login.dart';
import 'package:cheeky_chewer/utilities/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Log {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> register(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Navigator.pushReplacementNamed(context, Info.id))
          .catchError((e) {
        showErrorMsg(context, e.toString());
      });
    } catch (e) {
      e.runtimeType;
    }
  }

  Future<void> loggingUserData(
      BuildContext context,
      String? userEmail,
      String name,
      String userName,
      String profession,
      String profileUrl,
      String bio) async {
    try {
      await _cloudStore
          .collection('User Data')
          .add({
            'User Email': userEmail,
            'Name': name,
            'Username': userName,
            'Profession': profession,
            'Profile URL': profileUrl,
            'Bio': bio,
            'Time': FieldValue.serverTimestamp(),
          })
          .then((value) => Navigator.pushReplacementNamed(context, Login.id))
          .catchError((e) {
            showErrorMsg(context, e.toString());
          });
    } catch (e) {
      e.runtimeType;
    }
  }

  login(BuildContext context, String email, String password) {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Navigator.pushNamed(context, Homepage.id))
          .catchError((e) {
        showErrorMsg(context, e.toString());
      });
    } catch (e) {
      e.runtimeType;
    }
  }
}
