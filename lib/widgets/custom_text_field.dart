import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;  // novo

  const CustomTextField({
    required this.label,
    required this.controller,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator ??
              (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null,
    );
  }
}
