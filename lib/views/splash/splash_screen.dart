import 'package:flutter/material.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/views/home/bottom_navbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aami/viewmodels/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final isLogged =
          Provider.of<AuthProvider>(context, listen: false).isLogged;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLogged ? BottomNavBarPage() : LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Color(0xff1B262C)
          : Theme.of(context).primaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'aami',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 18.sp,
                    color: isDarkMode
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
            ),
            Text(
              'Store',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.sp,
                    color: isDarkMode
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
