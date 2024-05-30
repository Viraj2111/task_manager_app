import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/view/intro_view.dart';
import 'package:task_manager/view/tasksScreen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    timerNavigation();
  }

  timerNavigation() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => storage.read("isRead") == true
          ? const TaskScreen()
          : const IntroView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      body: Center(
        child: Image.asset(
          "assets/icon/png/splashLogo.png",
        ),
      ),
    );
  }
}
