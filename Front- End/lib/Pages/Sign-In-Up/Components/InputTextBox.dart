import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  const InputTextBox({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
      style: const TextStyle(color: Colors.black),
    );
  }
}