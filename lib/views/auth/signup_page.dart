import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/texfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                labelText: 'Username',
              ),
              CustomTextField(
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
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
        bottomNavigationBar: CustomBottomNavButton(
          onTap: () {},
          title: 'Sign Up',
        ),
      ),
    );
  }
}
