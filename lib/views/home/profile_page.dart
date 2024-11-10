import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavButton(
          onTap: () async {
            print('logout');
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);

            try {
              await authProvider.logout(
              );
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            } catch (e) {
              // Display the error message in a SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
          title: 'Log Out'),
    );
  }
}
