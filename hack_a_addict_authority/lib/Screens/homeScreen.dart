import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_a_addict_authority/Screens/landingPage.dart';
import 'package:hack_a_addict_authority/Screens/profilePage.dart';
import 'package:hack_a_addict_authority/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(items: [
        SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("Home")),
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
          ProfilePage()
        ],
      )
    );
  }
}