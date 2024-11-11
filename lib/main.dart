import 'package:aami/utils/theme.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/views/home/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart'; // Import provider package

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ), // Providing AuthProvider
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ), // Providing AuthProvider
      ],
      child: ScreenUtilInit(
        designSize:
            const Size(375, 812), // Set based on your design's base resolution
        minTextAdapt: true,
        builder: (context, child) {
          return Consumer<AuthProvider>(
            // Consumer to watch for changes in AuthProvider
            builder: (context, authProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme, // Light theme
                darkTheme: darkTheme, // Dark theme
                themeMode: ThemeMode
                    .system, // Automatically choose light or dark based on system preference
                home: authProvider
                        .isAuthenticated // If logged in, go to HomePage else LoginPage
                    ? BottomNavBarPage()
                    : LoginPage(),
              );
            },
          );
        },
      ),
    );
  }
}
