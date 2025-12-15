import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:github_per/core/constant/app_constant.dart';
import 'package:github_per/core/utils/themes/app_themes.dart';
import 'package:github_per/modules/home/home_view.dart';
import 'package:logger/logger.dart';

void main() {
  var logger = Logger();
  try {
    logger.i("Starting ${AppConstant.appName}...");
    runApp(const MyApp());
  } catch (e) {
    logger.e("Error starting the app: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.appName,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: const Scaffold(body: HomeView()),
        );
      },
    );
  }
}
