import 'package:aami/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  String? loginId;
  String? name;
  bool isLoading = false; // Loading state
  bool isLogged = false;
  bool rememberMe = true;

  AuthProvider() {
    loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    loginId = prefs.getString('loginId');
    name = prefs.getString('name');
    isLogged = prefs.getBool('isLogged') ?? false;

    notifyListeners();
  }

  // Save user data in SharedPreferences
  Future<void> saveUserData(String loginId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginId', loginId);
    await prefs.setString('name', name);

    if (rememberMe) {
  await prefs.setBool('isLogged', true);
}
  }

  // Clear user data from SharedPreferences
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginId');
    await prefs.remove('name');
    await prefs.setBool('isLogged', false);
  }

  // Set loading state
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Login method with error handling
  Future<void> login(String email, String password) async {
    setLoading(true); // Start loading
    try {
      final response = await authService.login(email, password);
      loginId = response['data']['loginid'];
      name = response['data']['name'];
      await saveUserData(loginId!, name!);
      isLogged = true;
    } catch (error) {
      print('Login error: $error');
      rethrow; // Pass the error to UI layer
    } finally {
      setLoading(false); // Stop loading
    }
  }

  // Signup method with error handling
  Future<void> signup(
      String email, String password, String name, String number) async {
    setLoading(true); // Start loading
    try {
      final response = await authService.signup(email, password, name, number);
      loginId = response['data']['loginid'];
      this.name = response['data']['name'];
      await saveUserData(loginId!, this.name!);
      isLogged = true;
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
      isLogged = false;
      await clearUserData();
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false); // Stop loading
    }
  }

  // Toggle logged state
  Future<void> toggleLoggedState(bool value) async {
    rememberMe = value; // Update the rememberMe variable
    notifyListeners(); // Notify listeners to update the UI
  }
}
