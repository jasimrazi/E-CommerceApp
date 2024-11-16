import 'package:aami/viewmodels/address_provider.dart';
import 'package:aami/views/address/addaddress_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/secondaryaddresscard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'All Addresses',
      ),
      body: addressProvider.isLoading
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                itemCount: addressProvider.addresses.length +
                    1, // Add extra item for the button
                itemBuilder: (context, index) {
                  if (index < addressProvider.addresses.length) {
                    final address = addressProvider.addresses[index];
                    return SecondaryAddressCard(
                      name: address.name,
                      country: address.country,
                      city: address.city,
                      phoneNumber: address.phoneNumber,
                      address: address.address,
                      isSelected:
                          addressProvider.selectedAddress?.id == address.id,
                      onSelect: () {
                        addressProvider.selectAddress(address.id);
                      },
                    );
                  } else {
                    // Render the add button after the last card
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Define your add address functionality here
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAddressPage(),
                                  ));
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
