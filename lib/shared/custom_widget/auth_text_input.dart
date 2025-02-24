import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextInput extends StatelessWidget {
  const AuthTextInput(
      {super.key,
      this.validator,
      this.controller,
      this.label,
      this.inputFormatter});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? label;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
