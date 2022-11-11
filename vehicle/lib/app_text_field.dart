import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final inputType;
  final inputAction;
  final controller;

  AppTextField({
    required this.controller,
    required this.hintText,
    this.inputType,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      textInputAction: inputAction,
      maxLength: 25,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        //don't show limit
        counterText: "",
        labelText: hintText,
        labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
        alignLabelWithHint: true,

        // hintText: hintText,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 1),
        ),
      ),
    );
  }
}
