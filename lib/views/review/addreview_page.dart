import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/secondarytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Add Review',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              SecondaryTextField(
                title: 'Name',
                hintText: 'Type your name',
              ),
              SizedBox(height: 20.h),
              SecondaryTextField(
                title: 'How was your experience?',
                hintText: 'Describe your experience',
                isMultiline: true,
              ),
              SizedBox(height: 20.h),
              Text(
                'Rate your experience',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    '0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Slider(
                        thumbColor: Theme.of(context).colorScheme.primary,
                        value: 3.0, // Default or placeholder value for now
                        min: 0,
                        max: 5,
                        divisions: 5,
                        onChanged: (_) {
                          // Empty callback for now, functionality to be added later
                        },
                        activeColor: Theme.of(context).colorScheme.surface,
                        inactiveColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  Text(
                    '5',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavButton(onTap: () {}, title: 'Submit Review'),
      ),
    );
  }
}
