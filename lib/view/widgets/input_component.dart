import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool? hasMaxLines;

  InputComponent({
    super.key,
    required this.controller,
    required this.hintText,
    this.hasMaxLines,
    this.isPassword = false,
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

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      // Se o campo for uma senha (obscureText), maxLines será 1
      maxLines: widget.isPassword ? 1 : (widget.hasMaxLines != null ? 4 : null),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                child:
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                onTap: _toggleVisibility,
              )
            : null,
        isDense: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
