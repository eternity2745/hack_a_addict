import 'package:animated_number/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack_a_addict/Database/databaseMethods.dart';
import 'package:hack_a_addict/Screens/homescreen.dart';
import 'package:hack_a_addict/Screens/landingpage.dart';
import 'package:hack_a_addict/Screens/quizResult.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuizScore extends StatefulWidget {
  const QuizScore({super.key});

  @override
  State<QuizScore> createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {

  int correctAnswers = 0;
  int totalQuestions = 0;
  int wrongAnswers = 0;
  int unattempted = 0;
  int totalScore = 0;

  updateScoreValues() {
    correctAnswers = Provider.of<StateManagement>(context, listen: false).correctAnswers;
    totalQuestions = Provider.of<StateManagement>(context, listen: false).quizResults.length;
    wrongAnswers = Provider.of<StateManagement>(context, listen: false).wrongAnswers;
    unattempted = totalQuestions - (correctAnswers + wrongAnswers);
    totalScore = (correctAnswers*5) - (wrongAnswers);
    setState(() {
      
    });
  }

  updateHighScore() async {
    await DatabaseMethods().updateHighScore({"highScore": totalScore}, Provider.of<StateManagement>(context, listen: false).id);
  }

  @override
  void initState() {
    super.initState();
    updateScoreValues();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Results"),
        ),
        body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 0.8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Total Score", style: TextStyle(
                          fontSize: 0.35.dp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        AnimatedNumber(
                          startValue: 0,
                          endValue: totalScore,
                          duration: Duration(seconds: 2), 
                          isFloatingPoint: false,
                          style: TextStyle(
                          fontSize: 0.45.dp,
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold
                        ),
                        ),
            
                        SizedBox(height: 0.4.h,),
                        Text("Correct Answers", style: TextStyle(
                          fontSize: 0.35.dp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        AnimatedNumber(
                          startValue: 0,
                          endValue: correctAnswers,
                          duration: Duration(seconds: 2), 
                          isFloatingPoint: false,
                          style: TextStyle(
                          fontSize: 0.4.dp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 0.4.h,),
                        Text("Wrong Answers", style: TextStyle(
                          fontSize: 0.35.dp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        AnimatedNumber(
                          startValue: 0,
                          endValue: wrongAnswers,
                          duration: Duration(seconds: 2), 
                          isFloatingPoint: false,
                          style: TextStyle(
                          fontSize: 0.4.dp,
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 0.4.h,),
                        Text("UnAttempted", style: TextStyle(
                          fontSize: 0.35.dp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        AnimatedNumber(
                          startValue: 0,
                          endValue: unattempted,
                          duration: Duration(seconds: 1), 
                          isFloatingPoint: false,
                          style: TextStyle(
                          fontSize: 0.4.dp,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Provider.of<StateManagement>(context, listen: false).correctAnswers = 0;
                        Provider.of<StateManagement>(context, listen: false).wrongAnswers = 0;
                        Provider.of<StateManagement>(context, listen: false).quizResults = [];
                        if (totalScore > Provider.of<StateManagement>(context, listen: false).quizHighScore) {
                          Provider.of<StateManagement>(context, listen: false).quizHighScore = totalScore;
                          updateHighScore();
                        }
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false,);
                      }, 
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(10.w, 7.h),
                        iconSize: 5.w,
                        shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                      ),
                      child: Icon(Icons.home),
                      ),
                    SizedBox(width: 4.w,),
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizResults()));
                      }, 
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(10.w, 7.h),
                        iconSize: 5.w,
                        shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                      ),
                      child: Icon(Icons.analytics_rounded),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}