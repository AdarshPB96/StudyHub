import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:studyhub/core/constants/api/urls.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController studyingforController = TextEditingController();
  TextEditingController schoolCollegeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final List<String> _selectedInterests = [];
  String? selectedGender;
  bool isAgreed = false;
  DateTime? dateOfBirth;
  String? country;
  String? state;
  String? city;
  List<String> get selectedInterests => _selectedInterests;
  String? get gender => selectedGender;
  bool loading = false;

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else {
      _selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void genderSelected(value) {
    selectedGender = value;
    notifyListeners();
  }

  void setDateOfBirth(DateTime selectedDate) {
    dateOfBirth = selectedDate;
    notifyListeners();
  }

  void setCountry(String countryValue) {
    country = countryValue;
    notifyListeners();
  }

  void setState(String stateValue) {
    state = stateValue;
    notifyListeners();
  }

  void setCity(String cityValue) {
    city = cityValue;
    notifyListeners();
  }

  Future<void> registerUser(Map<String, dynamic> userData) async {
    loading = true;
    notifyListeners();
    final apiUrl = Apiurls.baseUrl + Apiurls.registerUrl;
    log(apiUrl);

    try {
      log(userData.toString());
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final String? authToken = responseData['token'];
        if (authToken != null) {
          log("auth token : $authToken");
        }

        notifyListeners();

        print('User registered successfully');
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
    loading = false;
    notifyListeners();
  }
}
