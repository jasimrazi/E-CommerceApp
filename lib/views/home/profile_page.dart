import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/views/address/alladdress_page.dart';
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
              leading: const Icon(Icons.list_alt_outlined),
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
              leading: const Icon(Icons.import_contacts_outlined),
              title: Text(
                'All Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllAddresses()),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.redAccent,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.redAccent),
              ),
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
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
