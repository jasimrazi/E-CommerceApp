import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        SpinKitThreeBounce(
          color: Theme.of(context).colorScheme.secondary,
          size: 25,
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}