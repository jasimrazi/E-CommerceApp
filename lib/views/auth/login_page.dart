import 'package:aami/views/auth/signup_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/texfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 200.h),
                  child: Column(
                    children: [
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
                labelText: 'Username',
              ),
              CustomTextField(
                labelText: 'Password',
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
                        .copyWith(fontSize: 13.sp),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: CupertinoColors.activeGreen),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ));
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight:
                                        FontWeight.bold, // Change font weight
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary, // Change color
                                  ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavButton(
          onTap: () {},
          title: 'Login',
        ),
      ),
    );
  }
}
