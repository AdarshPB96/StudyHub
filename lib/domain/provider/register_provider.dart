import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  List<String> _selectedInterests = [];
  String? selectedGender;
  bool isAgreed = false;
   DateTime? dateOfBirth;

  List<String> get selectedInterests => _selectedInterests;
  String? get gender => selectedGender;

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
}
