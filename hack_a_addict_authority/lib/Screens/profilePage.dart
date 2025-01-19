import 'package:flutter/material.dart';
import 'package:hack_a_addict_authority/Database/databaseMethods.dart';
import 'package:hack_a_addict_authority/Screens/loginScreen.dart';
import 'package:hack_a_addict_authority/Utilities/stateManagement.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  logoutUser() async {
    Provider.of<StateManagement>(context, listen: false).updateUserInfo(policeID: 0, username: "", reviews: 0, profilePic: "", id: "");
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are You Sure You Want To Logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      child: Text("No")
                      ),
                    TextButton(
                      onPressed: () {
                        logoutUser();
                      }, 
                      child: Text("Yes")
                      )
                  ],
                );
              }
                );
            },
            child: Icon(Icons.logout_rounded)
            ),
          SizedBox(width: 4.w,),
        ],
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
                    "Police ID: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    "${Provider.of<StateManagement>(context).policeID}",
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
                    "Reviews Done: ",
                    style: TextStyle(
                      fontSize: 0.32.dp
                    ),
                  ),
                  Text(
                    "${Provider.of<StateManagement>(context).reviews}",
                    style: TextStyle(
                      fontSize: 0.32.dp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h,),
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
            ],
          ),
        ),
      ),
    );
  }
}