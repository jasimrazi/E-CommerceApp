import 'dart:convert';
import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/user/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Decode the response to get a specific error message from the API, if available
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['Message'] ?? 'Failed to log in');
      }
    } catch (error) {
      print(error);

      rethrow; // Rethrow the error without printing again
    }
  }

  Future<Map<String, dynamic>> signup(
      String email, String password, String name, String number) async {
    try {
      final url = Uri.parse('$baseUrl/user/register/user');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'email': email, 'password': password, 'name': name, 'number': number}),
      );


      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to sign up');
      }
    } catch (error) {
      rethrow; // Rethrow the error for handling in AuthProvider
    }
  }
}
