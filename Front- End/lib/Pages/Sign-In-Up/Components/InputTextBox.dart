import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final bool obscureText;
  final VoidCallback? toggleObscureText;

  const InputTextBox({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.toggleObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
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
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: toggleObscureText,
              )
            : null,
      ),
      validator: validator,
      style: const TextStyle(color: Colors.black),
    );
  }
}