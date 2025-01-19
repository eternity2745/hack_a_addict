import 'package:flutter/material.dart';
import 'package:hack_a_addict_authority/Screens/issueScreen.dart';
import 'package:hack_a_addict_authority/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        child: Consumer<StateManagement>(
          builder:(context, value, child) {
            return ListView.builder(
            itemCount: value.finalResults.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
                return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<StateManagement>(context, listen: false).updateSelectedReport(value.finalResults[index]);
                      Provider.of<StateManagement>(context, listen: false).updateSelectedReportID(index);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IssueScreen()));
                    },
                    child: Container(
                      height: 20.h,
                      width: 80.w,
                      // padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(15) 
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                value.finalResults[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 0.4.dp
                                ),
                                ),
                              Text(
                                "${value.finalResults[index]['dateTime'].toDate().year}/${value.finalResults[index]['dateTime'].toDate().month}/${value.finalResults[index]['dateTime'].toDate().day}",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reviewed?",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                Icon(value.finalResults[index]['reviewed'] == true ? Icons.check_box : Icons.close)
                              ],
                              )
                            ],
                         ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,)
                ],
              );
              }
            );
          },
        ),
      ),
    );
  }
}