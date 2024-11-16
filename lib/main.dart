import 'package:aami/utils/theme.dart';
import 'package:aami/viewmodels/address_provider.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/cart_provider.dart';
import 'package:aami/viewmodels/favourite_provider.dart';
import 'package:aami/viewmodels/order_provider.dart';
import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/viewmodels/selection_provider.dart';
import 'package:aami/viewmodels/review_provider.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/views/home/bottom_navbar.dart';
import 'package:aami/views/splash/splash_screen.dart'; // Add your Splash Screen import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(),
        ),
        ChangeNotifierProvider(create: (_) => SelectionProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: ScreenUtilInit(
        designSize:
            const Size(375, 812), // Set based on your design's base resolution
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme, // Light theme
            darkTheme: darkTheme, // Dark theme
            themeMode: ThemeMode
                .system, // Automatically choose light or dark based on system preference
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
