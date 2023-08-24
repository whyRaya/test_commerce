import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {super.key,
      required this.controller,
      this.isPasswordField = false,
      this.label = "",
      this.hint = ""});

  final TextEditingController controller;
  final bool isPasswordField;
  final String label;
  final String hint;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hint,
        labelText: widget.label,
        helperText: "",
        helperStyle: const TextStyle(color: Colors.green),
        suffixIcon: !widget.isPasswordField? null : IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        alignLabelWithHint: false,
        filled: true,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 16.0),
    );
  }
}
