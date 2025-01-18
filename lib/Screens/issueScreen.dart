import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<StateManagement>(context).selectedReport['title']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Review",
              style: TextStyle(
                fontSize: 0.45.dp,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              Provider.of<StateManagement>(context).selectedReport['reviewed'] == false ? "Yet to be reviewed" : Provider.of<StateManagement>(context).selectedReport['review'],
              style: TextStyle(
                fontSize: 0.3.dp
              ),
            ),
            SizedBox(height : 3.h),
            Text("Issue Details",
              style: TextStyle(
                fontSize: 0.45.dp,
                fontWeight: FontWeight.bold
              ),
            ),
            Text("Description",
              style: TextStyle(
                fontSize: 0.37.dp,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(Provider.of<StateManagement>(context).selectedReport['description'],
              style: TextStyle(
                fontSize: 0.3.dp
              ),
            ),
            SizedBox(height: 1.5.h),
            Text("Location",
              style: TextStyle(
                fontSize: 0.37.dp,
                fontWeight: FontWeight.bold
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("See Location In Map"),
                ),
            ),
            SizedBox(height: 0.37.h,),
            if (Provider.of<StateManagement>(context, listen: false).selectedReport['image'] != "")...{
              Text("Image",
              style: TextStyle(
                fontSize: 0.37.dp,
                fontWeight: FontWeight.bold
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("See Image"),
                ),
            ),
            } else...{
              SizedBox()
            }
          ],
        ),
      ),
    );
  }
}