import 'package:flutter/material.dart';
import 'package:hack_a_addict/Screens/AssistantScreen.dart';
import 'package:hack_a_addict/Screens/quizScreen.dart';
import 'package:hack_a_addict/Screens/rehabScreen.dart';
import 'package:hack_a_addict/Screens/reportIncident.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with AutomaticKeepAliveClientMixin {

  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
        child: Column(
          children: [
            Text(
              "Sample Text with a long quote for drug addiction anti drug addiction",
              style: TextStyle(
                fontSize: 0.3.dp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            Text(
              textAlign: TextAlign.end,
              "- Author Name",
              style: TextStyle(
                fontSize: 0.3.dp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            SizedBox(height: 5.h),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 5.w,
              crossAxisSpacing: 5.w,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportIncidentScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "Report Incident",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.31.dp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RehabMap()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "Rehabilitation Centers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.31.dp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Start Quiz?"),
                        content: Text("The questions for the quiz will be based on drug addiction and its effects"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
                            },
                            child: Text("Yes"),
                          )
                        ],
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "Quiz",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.31.dp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AssistantScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "AI Assistant",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.31.dp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  @override

  bool get wantKeepAlive => true;
}