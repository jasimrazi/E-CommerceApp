import 'package:aami/models/address_model.dart';
import 'package:aami/viewmodels/address_provider.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/secondarytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                SecondaryTextField(
                  title: 'Name',
                  controller: nameController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryTextField(
                        title: 'Country',
                        controller: countryController,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: SecondaryTextField(
                        title: 'City',
                        controller: cityController,
                      ),
                    ),
                  ],
                ),
                SecondaryTextField(
                  title: 'Phone Number',
                  controller: phoneController,
                ),
                SecondaryTextField(
                  title: 'Address',
                  controller: addressController,
                  isMultiline: true,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavButton(
          onTap: () async {
            if (nameController.text.isEmpty ||
                countryController.text.isEmpty ||
                cityController.text.isEmpty ||
                phoneController.text.isEmpty ||
                addressController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill out all fields')),
              );
            } else {
              try {
                final message = await addressProvider.addAddress(
                  authProvider.loginId!,
                  Address(
                    name: nameController.text,
                    country: countryController.text,
                    city: cityController.text,
                    phoneNumber: phoneController.text,
                    address: addressController.text,
                  ),
                );

                // Show success message only if there was no exception
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              } catch (e) {
                // Display the error message directly from the exception
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            }
          },
          title: 'Save Address',
          isLoading: addressProvider.isLoading,
        ),
      ),
    );
  }
}
