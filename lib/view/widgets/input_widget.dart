import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool isPassword;

  InputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false, // Define um valor padrão
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
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
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.deepPurple))),
    );
  }
}
