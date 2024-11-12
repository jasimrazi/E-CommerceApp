import 'package:aami/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  String? loginId;
  String? name;
  bool loading = false; // Loading state

  bool get isAuthenticated => loginId != null;

  AuthProvider() {
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    loginId = prefs.getString('loginId');
    name = prefs.getString('name');
    bool isLogged = prefs.getBool('isLogged') ?? false;

    if (isLogged && loginId != null) {
      notifyListeners();
    }
  }

  // Save user data in SharedPreferences
  Future<void> _saveUserData(String loginId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginId', loginId);
    await prefs.setString('name', name);
    await prefs.setBool('isLogged', true);
  }

  // Clear user data from SharedPreferences
  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginId');
    await prefs.remove('name');
    await prefs.setBool('isLogged', false);
  }

  // Set loading state
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  // Login method with error handling and rethrow
  Future<void> login(String email, String password) async {
    setLoading(true); // Start loading
    try {
      final response = await authService.login(email, password);

      print('///');
      print(response);
      print(response['data']['loginid']);
      print(response['data']['name']);
      print('///');

      loginId = response['data']['loginid'];
      name = response['data']['name'];
      await _saveUserData(loginId!, name!);
    } catch (error) {
      // Log error for debugging if needed
      print('Login error: $error');
      rethrow; // Pass the error to UI layer
    } finally {
      setLoading(false); // Stop loading
    }
  }

  // Signup method with error handling and rethrow
  Future<void> signup(String email, String password, String name, String number) async {
    setLoading(true); // Start loading
    try {
      final response = await authService.signup(email, password, name, number);
      loginId = response['data']['loginid'];
      name = response['data']['name'];
      await _saveUserData(loginId!, name!);
    } catch (error) {
      print('Signup error: $error');
      rethrow; // Pass the error to UI layer
    } finally {
      setLoading(false); // Stop loading
    }
  }

  // Logout method
  Future<void> logout() async {
    setLoading(true); // Start loading
    try {
      loginId = null;
      name = null;
      await _clearUserData();
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false); // Stop loading
    }
  }
}
