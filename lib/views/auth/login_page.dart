import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/views/auth/signup_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/texfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aami/views/home/bottom_navbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Create text controllers for username and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 200.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Welcome',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 28.sp),
                      ),
                      Text(
                        'Please enter your data to continue',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
              ),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.red,
                          fontSize: 15.sp,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remember me',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14.sp),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, _) {
                      return CupertinoSwitch(
                        value: authProvider.rememberMe,
                        onChanged: (value) {
                          authProvider.toggleLoggedState(value);
                        },
                        activeColor: CupertinoColors.activeGreen,
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13.sp,
                        ),
                    children: [
                      TextSpan(
                        text: 'Signup',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<AuthProvider>(
          builder: (context, authProvider, _) => CustomBottomNavButton(
            onTap: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);

              try {
                await authProvider.login(
                  emailController.text,
                  passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBarPage()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            title: 'Login',
            isLoading: authProvider.isLoading, // Pass loading state
          ),
        ),
      ),
    );
  }
}
