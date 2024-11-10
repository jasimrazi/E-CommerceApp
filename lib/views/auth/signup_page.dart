import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/views/auth/login_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/texfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

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
                  margin: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 28.sp),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                labelText: 'Name',
                controller: nameController,
              ),
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                controller: numberController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remember me',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Color(0xff1D1E20), fontSize: 13.sp),
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
              Text(
                'By creating an account, you confirm that you agree with our Terms and Conditions',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return CustomBottomNavButton(
            onTap: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);

              try {
                await authProvider.signup(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                    numberController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account Registered Successfully')),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            title: 'Sign Up',
            isLoading: authProvider.loading,
          );
        }),
      ),
    );
  }
}
