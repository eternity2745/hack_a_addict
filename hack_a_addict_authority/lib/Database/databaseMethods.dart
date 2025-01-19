import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:random_string/random_string.dart';

class DatabaseMethods {
  int policeID = 0;
  String password = "";

  FirebaseFirestore database = FirebaseFirestore.instance;
  // Codec<String, String> _stringToBase64 = utf8.fuse(base64);
  // String encoded = stringToBase64.encode(password);      // dXNlcm5hbWU6cGFzc3dvcmQ=
  // String decoded = stringToBase64.decode(encoded);

  Future<QuerySnapshot> policeLogin(int id, String password) async {
    QuerySnapshot result = await database.collection("authority").where("id", isEqualTo: id).get();
    return result;
  }

  Future<QuerySnapshot> getUserReports() async {
    return await database.collection("reports").where('reviewed', isEqualTo: false).get();
  }

  Future setReview(String id, Map<String, dynamic> data, String userID) async {
    await database.collection("authority").doc(userID).update({"reviews": FieldValue.increment(1)});
    await database.collection("reports").doc(id).update(data);
  }

}