import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack_a_addict/Database/databaseMethods.dart';
import 'package:hack_a_addict/Utilities/mapLocationPicker.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:sizer/sizer.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> readJson() async {
  final String response = await rootBundle.loadString('keys.json');
  final data = await json.decode(response);
  log(data[0]['maps']);
  }

  Future<void> addReport(Map<String, dynamic> reportInfo, String reportID, String id) async {
    int reports = Provider.of<StateManagement>(context, listen: false).reports;
    log("FINAL STAGES");
    Provider.of<StateManagement>(context, listen: false).updateUserInfo(reports: reports + 1);
    await DatabaseMethods().addUserReport(reportInfo, reportID, id);
    if (mounted) {
      Provider.of<StateManagement>(context, listen: false).setReportLocationCoordinates([]);
      Provider.of<StateManagement>(context, listen: false).setReportLocationAddress("Pick Location");
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Incident"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
        child: Column(
          children: [
            Text(
              "Fill in the details of the incident",
              style: TextStyle(
                fontSize: 0.3.dp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                suffixIconColor: Colors.black54,
                hintText: "Incident Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
            SizedBox(height: 3.h),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.description),
                suffixIconColor: Colors.black54,
                hintText: "Incident Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()));// Add code to pick location
              },
              child: Consumer<StateManagement>(
                builder: (context, value, child) {  
                return TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.location_on_outlined),
                    suffixIconColor: Colors.black54,
                    hintText: value.reportLocationAddress,
                    enabled: false,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black54)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                );
                }
              ),
            ),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () {
                log("Tapped");
              },
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.image_outlined),
                  suffixIconColor: Colors.black54,
                  hintText: "Attach Image (if any)",
                  enabled: false,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black54)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
                      onPressed: () {
                        log(Provider.of<StateManagement>(context, listen: false).reportLocationCoordinates.toString());
                        if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && Provider.of<StateManagement>(context, listen: false).reportLocationCoordinates != []) {
                          log("EE");
                           String reportID = randomAlphaNumeric(20);
                           int userID = Provider.of<StateManagement>(context, listen: false).userID;
                           log("E");
                           String title = titleController.text;
                           String description = descriptionController.text;
                           bool anonymous = false;
                           bool reviewed = false;
                           String review = "";
                           String image = "";
                           log("EEEE");
                           List<double> location = Provider.of<StateManagement>(context, listen: false).reportLocationCoordinates;
                           String id = Provider.of<StateManagement>(context, listen: false).id;
                           Map<String, dynamic> reportInfo = {
                            "userID": userID,
                            "title" : title,
                            "description" : description,
                            "anonymous" : anonymous,
                            "reviewed" : reviewed,
                            "review" : review,
                            "image" : image,
                            "location" : GeoPoint(location[0], location[1]),
                            "dateTime" : FieldValue.serverTimestamp()
                           };
                           log("ADDING REPORT");
                           addReport(reportInfo, reportID, id);

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the details")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(75.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: Row(
                        spacing: 3.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Report Incident"),
                          Icon(Icons.report_outlined)
                        ],
                      )
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
                      onPressed: () {
                          if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && Provider.of<StateManagement>(context, listen: false).reportLocationCoordinates != []) {
                          log("EE");
                           String reportID = randomAlphaNumeric(20);
                           int userID = Provider.of<StateManagement>(context, listen: false).userID;
                           log("E");
                           String title = titleController.text;
                           String description = descriptionController.text;
                           bool anonymous = true;
                           bool reviewed = false;
                           String review = "";
                           String image = "";
                           log("EEEE");
                           List<double> location = Provider.of<StateManagement>(context, listen: false).reportLocationCoordinates;
                           String id = Provider.of<StateManagement>(context, listen: false).id;
                           Map<String, dynamic> reportInfo = {
                            "userID": userID,
                            "title" : title,
                            "description" : description,
                            "anonymous" : anonymous,
                            "reviewed" : reviewed,
                            "review" : review,
                            "image" : image,
                            "location" : GeoPoint(location[0], location[1]),
                            "dateTime" : FieldValue.serverTimestamp()
                           };
                           log("ADDING REPORT");
                           addReport(reportInfo, reportID, id);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the details")));
                          }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(75.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: Row(
                        spacing: 3.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Report Incident Anonymously"),
                          Icon(Icons.private_connectivity_outlined)
                        ],
                      )
            )
          ],
        ),
      ),
    );
  }
}