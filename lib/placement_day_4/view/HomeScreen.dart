import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_daily_task/placement_day_4/Model.dart';
import 'package:placement_daily_task/placement_day_4/Service/colud.dart';
import 'package:placement_daily_task/placement_day_4/Service/google.dart';
import 'package:placement_daily_task/placement_day_4/Service/service.dart';
import 'package:placement_daily_task/placement_day_4/view/signin.dart';
class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('AuthService'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.authService.singOutUser();
                await GoogleAuthService.googleAuthService
                    .signOutFromGoogle();
                User? user =
                AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.off(const SingIn());
                }
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder(
    future: CloudFireStoreService.cloudFireStoreService
        .readCurrentUserFromFireStore(),
    builder: (context, snapshot) {
    if (snapshot.hasError) {
    return Center(
    child: Text(snapshot.error.toString()),
    );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }

    Map? data = snapshot.data!.data();
    UserModel userModel = UserModel.fromMap(data!);
    return Column(
    children: [
      SizedBox(height: 50,),
    Center(
      child: CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(userModel.image!),
      ),
    ),
    Text(
    userModel.name!,
    style: TextStyle(fontSize: 24),
    ),
    SizedBox(
    height: 5,
    ),
    Text(userModel.email!),
    Text(userModel.phone!),


    ],
    );
    }),
    );
  }
}
