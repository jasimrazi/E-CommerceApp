import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomBottomNavButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading; // New parameter to control loading state

  const CustomBottomNavButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.isLoading = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap, // Disable onTap when loading
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(15.0),
        height: 75.h,
        color: Theme.of(context).colorScheme.primary,
        child: isLoading
            ? Column(
                children: [
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              )
            : Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 17.sp, color: const Color(0xffFEFEFE)),
              ),
      ),
    );
  }
}
