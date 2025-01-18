import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Screen",
                style: TextStyle(
                  fontSize: 0.4.dp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 7.h),
                width: 80.w,
                height: 39.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade400,
                ),
                child: Column(
                  children: [
                    Form(
                      child: 
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.email,
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
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.key_off,
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
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () {},
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
              SizedBox(height: 5.h),
              ElevatedButton(
                      onPressed: () {},
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
      ),
    );
  }
}