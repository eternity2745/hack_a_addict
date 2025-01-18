import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {

  static final String apiKey = "AIzaSyA00pkaeu1i5GRQf6In6KkOmPK2Mp-yems";

  // ignore: non_constant_identifier_names
  List<String> AIResponses = ["Hello What Can I Do For You?"];
  List<String> userResponses = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speak with your Assistant!"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    ListView.builder(
                    itemCount: AIResponses.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        child: Text(AIResponses[index],
                          style: TextStyle(
                            fontSize: 0.32.dp
                          ),
                        ),
                      );
                    }
                    ),
                    SizedBox(height: 2.h,),
                    ListView.builder(
                    itemCount: AIResponses.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(AIResponses[index],
                          style: TextStyle(
                            fontSize: 0.32.dp
                          ),
                        ),
                      );
                    }
                    ),
                  ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w, left: 5.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                suffixIcon: Icon(Icons.send)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}