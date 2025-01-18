import 'package:flutter/material.dart';
import 'package:hack_a_addict/Database/databaseMethods.dart';
import 'package:hack_a_addict/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  changePassword() async {
    String email = Provider.of<StateManagement>(context, listen: false).email;
    bool result = await DatabaseMethods().changePassword(email);
    if (result && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Reset Mail Sent To Your Gmail")));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable To Reset Password At The Moment!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(Provider.of<StateManagement>(context).profilePic),
                radius: 8.h,
              ),
              SizedBox(height: 6.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    Provider.of<StateManagement>(context).email,
                    style: TextStyle(
                      fontSize: 0.32.dp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Username: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    Provider.of<StateManagement>(context).username,
                    style: TextStyle(
                      fontSize: 0.32.dp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Reports Done: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    "${Provider.of<StateManagement>(context).reports}",
                    style: TextStyle(
                      fontSize: 0.32.dp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quiz High Score: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    "${Provider.of<StateManagement>(context).quizHighScore}",
                    style: TextStyle(
                      fontSize: 0.32.dp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h,),
              ElevatedButton(onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(60.w, 7.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ), 
              child: Text(
                "Edit User Data",
              ),
              ),
              SizedBox(height: 2.h,),
              ElevatedButton(onPressed: () {
                changePassword();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(60.w, 7.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ), 
              child: Text(
                "Change Password",
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}