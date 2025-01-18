import 'package:flutter/material.dart';
import 'package:hack_a_addict/Database/databaseMethods.dart';
import 'package:hack_a_addict/Screens/homescreen.dart';
import 'package:hack_a_addict/Screens/loginscreen.dart';
import 'package:random_string/random_string.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  signUp() async {
    if (passwordController.text == confirmPasswordController.text) {
      bool result = await DatabaseMethods().userSignUp(emailController.text, usernameController.text, passwordController.text);

      if (result == false) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign Up Failed: Please check your email and try again.")));
        }
      }else {
         await DatabaseMethods().addUserInfo({
            "username": usernameController.text,
            "email": emailController.text,
            "profilePic" : "https://www.pinclipart.com/picdir/big/218-2189254_free-online-avatars-kid-characters-family-vector-for.png",
            "reports" : 0,
            "highScore" : 0,
            "id" : DateTime.now().millisecondsSinceEpoch
          }, randomAlphaNumeric(20));
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
        );
      }
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 11.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up Screen",
                style: TextStyle(
                  fontSize: 0.4.dp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 7.h),
                width: 80.w,
                height: 57.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade400,
                ),
                child: Column(
                  children: [
                    Form(
                      child: 
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      child: 
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      child: 
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.key_off_outlined,
                            color: Colors.black54,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      child: 
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.key_off_outlined,
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.purple)
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: Text("Sign Up")
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50.w, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      child: Text("Login")
                    )
            ],
          ),
        ),
      ),
    );
  }
}