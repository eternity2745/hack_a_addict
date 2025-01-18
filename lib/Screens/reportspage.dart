import 'package:flutter/material.dart';
import 'package:hack_a_addict/Screens/issueScreen.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Consumer<StateManagement>(
          builder: (context, value, child) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.userReports.length,
              itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<StateManagement>(context, listen: false).updateSelectedReport(value.userReports[index]);
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
                                value.userReports[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 0.4.dp
                                ),
                                ),
                              Text(
                                "${value.userReports[index]['dateTime'].toDate().year}/${value.userReports[index]['dateTime'].toDate().month}/${value.userReports[index]['dateTime'].toDate().day}",
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
                                Icon(value.userReports[index]['reviewed'] == true ? Icons.check_box : Icons.close)
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
          }
        ),
      ),
    );
  }
}