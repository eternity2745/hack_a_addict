import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuizResults extends StatefulWidget {
  const QuizResults({super.key});

  @override
  State<QuizResults> createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {

  List<Map<String, dynamic>> quizResults = [];
  int questionIndex = 0;
  PageController controller = PageController();
  String correctAnswer = "";
  String question = "";

  @override 
  void initState() {
    super.initState();
    quizResults = Provider.of<StateManagement>(context, listen: false).quizResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Quiz Analysis"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, left: 3.w, right: 3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: 
                    Row(               
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                        width: 60.w,
                        child: LinearProgressIndicator(
                          value: (questionIndex+1)/10,
                          backgroundColor: Colors.red.shade900,
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      SizedBox(width: 1.w,),
                      Text(
                        "${questionIndex+1}/10",
                        style: TextStyle(
                          fontSize: 0.3.dp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                        )
                    ],
                  ),    
                ),
              SizedBox(height: 0.4.h,),
              SizedBox(
                          width: double.infinity,
                          height: 60.h,
                          child: PageView.builder(
                            controller: controller,
                            itemCount: 10,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              correctAnswer = quizResults[questionIndex]['a'];
                              question = quizResults[questionIndex]['q'];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                    height: 57.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.blue.shade400
                                    ),
                                    child: Column(
                                      children: [
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          height: 15.h,
                                          child: AutoSizeText(question,
                                                      // stepGranularity: 10,
                                                      style: TextStyle(
                                                        fontSize: 0.4.dp,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                      ),
                                                      ),
                                        ),
                                        SizedBox(height: 3.h,),
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          height: 30.h,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Column(
                                              children: [
                                                ElevatedButton(
                                                      onPressed: () {
                                                      }, 
                                                      style: ButtonStyle(
                                                        fixedSize: WidgetStateProperty.all(Size(100.w, 1.7.h)),
                                                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(14),
                                                          side: BorderSide(color: quizResults[questionIndex]['sa'] == "None" ? Colors.black26 : quizResults[questionIndex]['o1'] == correctAnswer ? Colors.green : quizResults[questionIndex]['o1'] == quizResults[questionIndex]['sa'] ? Colors.red : Colors.black26, width: 3.0)
                                                        ))
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(quizResults[questionIndex]['o1'], style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 0.32.dp
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                          ),
                                                        ),
                                                      )
                                                ),
                                                SizedBox(height: 1.h,),
                                                ElevatedButton(
                                                      onPressed: () {
                                                      }, 
                                                      style: ButtonStyle(
                                                        fixedSize: WidgetStateProperty.all(Size(100.w, 1.7.h)),
                                                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(14),
                                                          side: BorderSide(color: quizResults[questionIndex]['sa'] == "None" ? Colors.black26 : quizResults[questionIndex]['o2'] == correctAnswer ? Colors.green : quizResults[questionIndex]['o2'] == quizResults[questionIndex]['sa'] ? Colors.red : Colors.black26, width: 3.0)
                                                        ))
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(quizResults[questionIndex]['o2']
                                                          ,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 0.32.dp
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                          ),
                                                        ),
                                                      )
                                                ),
                                                SizedBox(height: 1.h,),
                                                ElevatedButton(
                                                      onPressed: () {
                                                      }, 
                                                      style: ButtonStyle(
                                                        fixedSize: WidgetStateProperty.all(Size(100.w, 1.7.h)),
                                                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(14),
                                                          side: BorderSide(color: quizResults[questionIndex]['sa'] == "None" ? Colors.black26 : quizResults[questionIndex]['o3'] == correctAnswer ? Colors.green : quizResults[questionIndex]['o3'] == quizResults[questionIndex]['sa'] ? Colors.red : Colors.black26, width: 3.0)
                                                        ))
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(quizResults[questionIndex]['o3'], style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 0.32.dp
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                          ),
                                                        ),
                                                      )
                                                ),
                                                SizedBox(height: 1.h),
                                                ElevatedButton(
                                                      onPressed: () {
                                                        
                                                      }, 
                                                      style: ButtonStyle(
                                                        fixedSize: WidgetStateProperty.all(Size(100.w, 1.7.h)),
                                                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(14),
                                                          side: BorderSide(color: quizResults[questionIndex]['sa'] == "None" ? Colors.black26 : quizResults[questionIndex]['o4'] == correctAnswer ? Colors.green : quizResults[questionIndex]['o4'] == quizResults[questionIndex]['sa'] ? Colors.red : Colors.black26, width: 3.0)
                                                        ))
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(quizResults[questionIndex]['o4'], style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 0.32.dp
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                          ),
                                                        ),
                                                      )
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            ),
                        ),
                  ElevatedButton(
                      onPressed: () {
                        if (questionIndex <= 8) {
                          controller.nextPage(
                              duration: Duration(milliseconds: 500), 
                              curve: Curves.fastLinearToSlowEaseIn
                            );
                          questionIndex++;
                          setState(() {
                            
                          });
                        }else{
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: questionIndex <= 8 ? Text("Next") : Text("End")
                    )
            ],
          ),
        ),
      )
    );
  }
}