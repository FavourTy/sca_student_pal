import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextInput extends StatefulWidget {
  const PasswordTextInput(
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
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        inputFormatters: widget.inputFormatter,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ));
  }
}
