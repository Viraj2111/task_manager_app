import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/view/splash_view.dart';
import 'package:task_manager/view/tasksScreen.dart';

/// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black).copyWith(
            background: appBlackColor,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: appBlackColor,
          ),
        ),
        home: SplashView(), 
        
      ),
    );
  }
}
