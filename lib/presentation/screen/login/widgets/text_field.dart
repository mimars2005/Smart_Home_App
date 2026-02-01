import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.isPassword = false});
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword,
      controller: widget.controller,
      enableInteractiveSelection: false,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.label,
        icon: Icon(
          widget.icon,
        ),
        iconColor: const Color.fromARGB(255, 255, 255, 255),
        hintStyle:
            const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 13),
      ),
    );
  }
}
