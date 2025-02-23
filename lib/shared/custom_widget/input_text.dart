import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText(
      {super.key, this.title, this.myHintText, this.controller, this.readOnly});
  final String? title;
  final String? myHintText;
  final TextEditingController? controller;
  final bool? readOnly;
  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          decoration: InputDecoration(hintText: widget.myHintText),
        )
      ],
    );
  }
}
