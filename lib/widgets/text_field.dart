import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconButton? suffixIcon; // Optional suffix icon
  final VoidCallback?
      onSuffixIconPressed; // Optional callback for suffix icon press
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  final String? textTop;

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.textTop,
    this.validator,
    this.obscureText = false,
  });

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
        textTop != null ? const SizedBox(height: 12) : const SizedBox(),
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
                color: Colors.grey.shade400,
              ),
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
