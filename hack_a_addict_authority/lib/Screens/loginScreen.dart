import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hack_a_addict_authority/Database/databaseMethods.dart';
import 'package:hack_a_addict_authority/Screens/homeScreen.dart';
import 'package:hack_a_addict_authority/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userLogin() async {
    QuerySnapshot details = await DatabaseMethods().policeLogin(int.parse(idController.text), passwordController.text);
    log("${details.docs}");
    if (details.docs.isEmpty || details.docs[0]['password'] != passwordController.text) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invaild Login Credentials")));
      }    
    } else {
      String username = "${details.docs[0]["name"]}";
      String photo = "${details.docs[0]["profilePic"]}";
      int policeID = details.docs[0]['id'];
      int reviews = details.docs[0]['reviews'];
      String id = details.docs[0].id;
      GeoPoint location = GeoPoint(details.docs[0]['station'].latitude, details.docs[0]['station'].longitude);
      if (mounted) {
        Provider.of<StateManagement>(context, listen: false).updateUserInfo(username: username, policeID: policeID, profilePic: photo, reviews: reviews, id : id, location: location);
        QuerySnapshot results = await DatabaseMethods().getUserReports();
        List<Map<String, dynamic>> finalResults = [];
        List<String> reportIDs = [];
        for (var i in results.docs) {
          GeoPoint l1 = (i.data() as Map<String, dynamic>)['location'];
          double distance = Geolocator.distanceBetween(location.latitude, location.longitude, l1.latitude, l1.longitude);
          if (distance/1000 <= 2) {
            finalResults.add(i.data() as Map<String, dynamic>);
            reportIDs.add(i.id);
          }
          Provider.of<StateManagement>(context, listen: false).updateFinalResults(finalResults);
          Provider.of<StateManagement>(context, listen: false).updateReportIDs(reportIDs);
          
        }
        if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
       }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Screen",
                style: TextStyle(
                  fontSize: 0.4.dp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 7.h),
                width: 80.w,
                height: 39.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade400,
                ),
                child: Column(
                  children: [
                    Form(
                      child: 
                      TextFormField(
                        controller: idController,
                        decoration: InputDecoration(
                          hintText: "Police ID",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      child: 
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.key_off,
                            color: Colors.black54,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () {
                        userLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: Text("Login")
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}