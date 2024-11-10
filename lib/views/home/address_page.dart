import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/secondarytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                SecondaryTextField(title: 'Name'),
                Row(
                  children: [
                    Expanded(child: SecondaryTextField(title: 'Country')),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(child: SecondaryTextField(title: 'City')),
                  ],
                ),
                SecondaryTextField(title: 'Phone Number'),
                SecondaryTextField(
                  title: 'Address',
                  isMultiline: true,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavButton(onTap: () {}, title: 'Save Address'),
      ),
    );
  }
}
