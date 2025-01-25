
import 'package:flutter/material.dart';
import 'package:placement_daily_task/placement_day_4/Service/service.dart';
import 'package:placement_daily_task/placement_day_4/view/HomeScreen.dart';
import 'package:placement_daily_task/placement_day_4/view/signin.dart';
class AuthManger extends StatelessWidget {
  const AuthManger({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser()==null)?SingIn():Homescreen();
  }
}
