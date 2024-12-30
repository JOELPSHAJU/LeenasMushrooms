// Reusable Login Button
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const MainButton({super.key, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 55, // Responsive height
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(AppColors.secondaryColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
