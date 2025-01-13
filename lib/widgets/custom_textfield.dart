import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintTextName,
    this.isPassword = false,
    this.controller,
  });

  final String hintTextName;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 70,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.blue.shade300,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
          ),
          filled: true,
          fillColor: Color.fromRGBO(249, 249, 249, 1),
          hintText: hintTextName,
          hintStyle: TextStyle(
              color: Color.fromRGBO(135, 135, 135, 1),
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
