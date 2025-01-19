import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_a_addict_authority/Screens/loginScreen.dart';
import 'package:hack_a_addict_authority/Utilities/stateManagement.dart';
import 'package:hack_a_addict_authority/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateManagement(),
      child: Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400
          ),
          useMaterial3: true,
        ),
      //   home: FutureBuilder(
      //   future: DatabaseMethods().getcurrentUser(),
      //   builder: (context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.hasData) {
      //       return HomeScreen();
      //     }else{
      //       return LoginScreen();
      //     }
      //   }
      //  ),
      home: LoginScreen()
      ),
    )
    );
  }
}