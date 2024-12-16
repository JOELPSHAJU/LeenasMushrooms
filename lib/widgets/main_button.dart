// Reusable Login Button
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/color.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const MainButton({super.key, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60, // Responsive height
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
