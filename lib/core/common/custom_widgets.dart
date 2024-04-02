import 'package:flutter/material.dart';
import 'package:studyhub/core/constants/global_variables.dart';

class CustomTextFormfield extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final double? width;
  final double? height;

  const CustomTextFormfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(0),
          //   borderSide: BorderSide(color: Colors.black),
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide:
                BorderSide(color: Colors.black), // Add border color here
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
     gradient: GlobalVariables.gradient,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
              color: GlobalVariables.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0, // Remove elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
