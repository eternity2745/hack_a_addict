import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {

  static final String apiKey = "";


  late GenerativeModel _model;
  final TextEditingController _controller = TextEditingController();
  int promptIndex = 0;

  final prompt = "You Are An AI Assistant in an App for helping people overcome drug addiction named Navjeev. App Offers features like Finding Rehabs, Reporting Incident, engage in drug awareness quiz games. Your role is to help the users with their needs in overcoming drug addiction or a motivation to like report a stranger who is a drug addict. Analyse the prompt carefully.";
  List<Content> content = [];

  // ignore: non_constant_identifier_names
  List<String> userAIResponses = ["Hello What Can I Do For You?"];


  addAIResponse() async {
    userAIResponses.add(_controller.text);
    promptIndex++;
    setState(() {
      
    });
    content = [Content.text("You Are An AI Assistant in an App for helping people overcome drug addiction named Navjeev. App Offers features like Finding Rehabs, Reporting Incident, engage in drug awareness quiz games. Your role is to help the users with their needs in overcoming drug addiction or a motivation to like report a stranger who is a drug addict. Analyse the prompt carefully: ${_controller.text}")];
    final response = await _model.generateContent(content);
    userAIResponses.add(response.text as String);
    _controller.clear();
    promptIndex++;
    setState(() {
      
    });
  }

  startAssistant() async {
    _model = GenerativeModel(
      model: "gemini-2.0-flash-exp", 
      apiKey: apiKey
      );
    promptIndex = 0;
  }

  @override
  void initState() {
    super.initState();
    startAssistant();
  }


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
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.h),
                child: Column(
                  children: [
                    ListView.builder(
                    itemCount: userAIResponses.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: promptIndex%2 != 0 ? Colors.blue.shade400 : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Text(userAIResponses[promptIndex],
                              style: TextStyle(
                                fontSize: 0.32.dp
                              ),
                            ),
                            SizedBox(height: 2.h,),
                          ],
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
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter Message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    addAIResponse();
                  },
                  child: Icon(Icons.send))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}