import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/address_model.dart';

class AddressService {
  // Fetch addresses for a user
  Future<List<Address>> fetchAddresses(String loginId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/address/$loginId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['addresses'];
        return data
            .map((addressJson) => Address.fromJson(addressJson))
            .toList();
      } else if (response.statusCode == 404) {
        String data = jsonDecode(response.body)['message'];
        throw Exception(data);
      } else {
        throw Exception('Failed to load addresses');
      }
    } catch (e) {
      print('Error fetching addresses: $e');
      return [];
    }
  }

  // Add a new address for a user
  Future<String> addAddress(String loginId, Address address) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/address/add/$loginId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(address.toJson()),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        // Successfully added
        return jsonDecode(response.body)['message'];
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('message')) {
          return responseData['message'];
        } else if (responseData.containsKey('phone_number')) {
          return responseData['phone_number'][0];
        }
      }
      throw Exception('Failed to add address');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
