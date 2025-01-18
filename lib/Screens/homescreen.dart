import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_a_addict/Database/databaseMethods.dart';
import 'package:hack_a_addict/Screens/landingpage.dart';
import 'package:hack_a_addict/Screens/profilepage.dart';
import 'package:hack_a_addict/Screens/reportspage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController();

  getQuizQuestions() async {
    QuerySnapshot questions = await DatabaseMethods().getQuizQuestions();
    List<Object?> quizQuestions = [];

    for (var i in questions.docs) {
      quizQuestions.add(i.data());
    }
  }

  @override
  void initState() {
    super.initState();
    getQuizQuestions();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(items: [
        SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("Home")),
        SalomonBottomBarItem(icon: Icon(Icons.list_alt_rounded), title: Text("Reports")),
        SalomonBottomBarItem(icon: Icon(Icons.person), title: Text("Profile")),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      backgroundColor: Colors.deepPurple,
      onTap: (index) {
        _pageController.jumpToPage(index);
        setState(() {
          selectedIndex = index;
        });
      },
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          LandingPage(),
          ReportsPage(),
          ProfilePage()
        ],
      )
    );
  }
}