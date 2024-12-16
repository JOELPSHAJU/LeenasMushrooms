import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon; // Optional suffix icon
  final VoidCallback?
      onSuffixIconPressed; // Optional callback for suffix icon press
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final double height;
  final String? textTop;

  const PasswordField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      this.suffixIcon,
      this.onSuffixIconPressed,
      this.textTop,
      this.validator,
      this.obscureText = false,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textTop ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Colors.white,
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.grey,
              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(suffixIcon, color: Colors.grey),
                      onPressed: onSuffixIconPressed,
                    )
                  : null,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
