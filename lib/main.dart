import 'package:aami/utils/theme.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/views/home/bottom_navbar.dart';
import 'package:aami/views/home/home_page.dart';
import 'package:aami/views/product/single_product.dart';
import 'package:aami/views/review/addreview_page.dart';
import 'package:aami/views/review/allreview_page.dart';
import 'package:aami/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // Set based on your design's base resolution
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Set the theme and dark theme
          theme: lightTheme, // Light theme
          darkTheme: darkTheme, // Dark theme
          themeMode: ThemeMode
              .system, // Automatically chooses light or dark based on the system preference

          home: child,
        );
      },
      child: AddReviewPage(),
    );
  }
}
