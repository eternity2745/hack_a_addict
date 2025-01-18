import 'package:flutter/cupertino.dart';

class StateManagement with ChangeNotifier {
  
  String reportLocationAddress = "";

  void setReportLocationAddress(String address) {
    reportLocationAddress = address;
    notifyListeners();
  }
}