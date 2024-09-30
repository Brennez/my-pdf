import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool isPassword;
  bool? hasMaxLines;

  InputComponent({
    super.key,
    required this.controller,
    required this.hintText,
    this.hasMaxLines,
    this.isPassword = false, // Define um valor padrão
  });

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  bool? showIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      maxLines: widget.hasMaxLines != null ? 4 : null,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  child: Icon(obscureText == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onTap: () => _toggleVisibility(),
                )
              : null,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.deepPurple))),
    );
  }
}
