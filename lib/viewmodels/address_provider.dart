import 'package:aami/models/address_model.dart';
import 'package:aami/services/address_service.dart';
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  final AddressService addressService = AddressService();
  List<Address> addresses = [];
  Address? selectedAddress;
  bool isLoading = false;
  bool fetchTrigger = false;
  String errorMessage = '';

  // Fetch addresses for a user
  Future<void> fetchAddresses(String loginId) async {
    
    if (addresses.isEmpty || fetchTrigger) {
      isLoading = true;
      errorMessage = '';
      notifyListeners();
      try {
        addresses = await addressService.fetchAddresses(loginId);

        // Set the first address as the default selected address
        if (addresses.isNotEmpty) {
          selectedAddress = addresses.first;
        }
      } catch (e) {
        errorMessage = 'Error fetching addresses: $e';
        addresses = [];
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  // Add a new address for a user
   Future<String> addAddress(String loginId, Address address) async {
    isLoading = true;
    notifyListeners();
    try {
      final message = await addressService.addAddress(loginId, address);
      fetchTrigger = true;
      await fetchAddresses(loginId); // Refresh address list

      // Set the first address as the default selected address after refresh
      if (addresses.isNotEmpty && selectedAddress == null) {
        selectedAddress = addresses.first;
      }
      // Return the success message from the service
      return message;
    } catch (e) {
      throw Exception(e.toString()); // Throw the exception directly
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // Change the selected address based on the address ID
  void selectAddress(int? addressId) {
    if (addressId != null) {
      selectedAddress = addresses.firstWhere(
        (address) => address.id == addressId,
        orElse: () =>
            selectedAddress ??
            Address(
              id: -1,
              user: -1,
              name: '',
              country: '',
              city: '',
              phoneNumber: '',
              address: '',
            ),
      );
    }
    notifyListeners();
  }

  // Clear the list of addresses
  void clearAddresses() {
    addresses = [];
    selectedAddress = null;
    notifyListeners();
  }
}
