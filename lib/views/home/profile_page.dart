import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/views/home/orders_page.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          authProvider.name ?? '',
          style:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Account',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(
                'View Orders',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {},
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text(
                'Change Password',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {},
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavButton(
        onTap: () async {
          try {
            await authProvider.logout();
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
        title: 'Log Out',
      ),
    );
  }
}
