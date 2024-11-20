import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  const CustomFormTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.textInputType,
    this.isPassword = false,
    this.validator,
  });
  final TextEditingController? controller;
  final String label;
  final TextInputType textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: widget.validator,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword ? isObscured : false,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? IconButton(
                onPressed: () {
                  isObscured = !isObscured;
                  setState(() {});
                },
                icon: isObscured
                    ? const Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.visibility_rounded,
                        color: Colors.white,
                      ),
              )
            : null,
        label: Text(widget.label),
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
