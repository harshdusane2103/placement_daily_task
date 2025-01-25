//


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_daily_task/placement_day_4/view/HomeScreen.dart';
import 'package:placement_daily_task/placement_day_4/view/google_signin.dart';
import 'package:placement_daily_task/placement_day_4/view/signin.dart';
import 'package:placement_daily_task/placement_day_4/view/signup.dart';
import 'firebase_options.dart';



Future<void> main() async {
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

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,

        //
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        // themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
        getPages: [


          GetPage(name: '/', page:()=>AuthManger(),transition: Transition.rightToLeft),
          GetPage(name: '/singIn', page:()=>SingIn(),transition: Transition.rightToLeft),
          GetPage(name: '/singUp', page:()=>SignUp(),transition: Transition.rightToLeft),
          GetPage(name: '/home', page:()=>Homescreen(),transition: Transition.rightToLeft),


        ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:placement_daily_task/placement_day_2/Login/login.dart';
//
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Placement Task Day 2',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
