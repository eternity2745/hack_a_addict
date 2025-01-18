import 'dart:developer';

import 'package:flutter/cupertino.dart';

class StateManagement with ChangeNotifier {
  
  String reportLocationAddress = "Pick Location";
  List<double> reportLocationCoordinates = [];
  int userID= 0;
  String id = "";
  String email = "";
  String username = "";
  int reports = 0;
  int quizHighScore = 0;
  String profilePic = "";
  List<Map<String, dynamic>> quizQuestions = [];
  List<Map<String, dynamic>> quizResults = [];
  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<Map<String, dynamic>> userReports = [];
  Map<String, dynamic> selectedReport = {};

  void updateUserInfo({int? userID, String? email, String? username, int? reports, int? quizHighScore, String? profilePic, String? id}) {
    if (userID != null) {
      this.userID = userID;
    }
    if (email != null) {
      this.email = email;
    }
    if (username != null) {
      this.username = username;
    }
    if (reports != null) {
      this.reports = reports;
    }
    if (quizHighScore != null) {
      this.quizHighScore = quizHighScore;
    }
    if (profilePic != null) {
      this.profilePic = profilePic;
    }
    if (id != null) {
      this.id = id;
    }
    notifyListeners();

  }

  void updateSelectedReport(Map<String, dynamic> report) {
    selectedReport = report;
    notifyListeners();
  }

  void updateUserReports(reports) {
    userReports = reports;
    notifyListeners();
  }

  void setReportLocationAddress(String address) {
    reportLocationAddress = address;
    notifyListeners();
  }

  void setReportLocationCoordinates(List<double> coordinates) {
    reportLocationCoordinates = coordinates;
  }

  void setQuizQuestions(List<Map<String, dynamic>> questions) {
    quizQuestions = questions;
    notifyListeners();
  }

  getQuizQuestions() {
    quizQuestions.shuffle();
    return quizQuestions.getRange(0, 10).toList();
  }

  void setQuizResults(List<Map<String, dynamic>> quizResults) {
    this.quizResults = quizResults;
  }

  void updateCorrectAnswers() {
    correctAnswers++;
  }

  void updateWrongAnswers() {
    wrongAnswers++;
  }
}