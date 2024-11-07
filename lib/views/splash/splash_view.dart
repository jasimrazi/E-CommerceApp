import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          'a a m i',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 25,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
