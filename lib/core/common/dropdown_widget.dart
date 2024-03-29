import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyhub/core/constants/global_variables.dart';
import 'package:studyhub/domain/provider/register_provider.dart';
import 'package:studyhub/screens/register/register_screen.dart';

class CustomDropDownButton extends StatelessWidget {
  // final double w;
  final double h;
  const CustomDropDownButton({Key? key, required this.h}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      headingWidget(text: 'Gender'),
      GlobalVariables.height10,
      Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) {
          if (registerProvider.selectedGender == null ||
              !['Male', 'Female', 'Other']
                  .contains(registerProvider.selectedGender)) {
            // If not, set it to null so that no item is preselected
            registerProvider.selectedGender = null;
          }
          return Container(
            height: h * 0.045,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<String>(
              value: registerProvider.gender,
              underline: const SizedBox(),
              onChanged: (String? value) {
                registerProvider.genderSelected(value);
              },
              items: <String?>[null, 'Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value ?? 'Select Gender',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    ]);
  }
}
