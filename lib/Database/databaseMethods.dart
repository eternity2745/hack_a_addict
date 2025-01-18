import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {

  String email = "";
  String username = "";


  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future userLogin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future userSignUp(String email, String username, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      log("Created");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    } 
  }

  Future addUserInfo(Map<String, dynamic> userInfo, String? id) async {
    try {
      log("Adding");
      return await database.collection("users").doc(id).set(userInfo);
    } catch (e) {
      return false;
    }
  }



}