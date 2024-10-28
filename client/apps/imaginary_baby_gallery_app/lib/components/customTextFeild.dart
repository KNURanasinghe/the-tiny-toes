import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  double? width;
  String labelText;
  String hintText;
  TextEditingController controller;
  CustomTextFeild({
    super.key,
    this.width = 300,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
