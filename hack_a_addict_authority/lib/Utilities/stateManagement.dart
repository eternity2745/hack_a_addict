import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StateManagement with ChangeNotifier {
  
  String username = "";
  String profilePic = "";
  int policeID = 0;
  int reviews = 0;
  String id = "";
  GeoPoint location = GeoPoint(0, 0);
  List<Map<String, dynamic>> finalResults = [];
  Map<String, dynamic> selectedReport = {};
  List<String> reportIDs = [];
  String selectedReportID = "";

  void updateUserInfo({int? policeID, String? username, int? reviews, String? profilePic, String? id, GeoPoint? location}) {
    if (policeID != null) {
      this.policeID = policeID;
    }
    if (username != null) {
      this.username = username;
    }
    if (reviews != null) {
      this.reviews = reviews;
    }
    if (profilePic != null) {
      this.profilePic = profilePic;
    }
    if (id != null) {
      this.id = id;
    }
    if (location != null) {
      this.location = location;
    }
    notifyListeners();
  } 

  updateFinalResults(List<Map<String, dynamic>> finalResults) {
    this.finalResults = finalResults;
  }

  updateSelectedReport(Map<String, dynamic> selectedReport) {
    this.selectedReport = selectedReport;
  }

  updateReportIDs(List<String> reportIDs) {
    this.reportIDs = reportIDs;
  }

  updateSelectedReportID(int index) {
    selectedReportID = reportIDs[index];
  }
}