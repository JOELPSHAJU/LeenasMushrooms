import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';

void customSnackbar(
  context,
  message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.grey300,
      duration: const Duration(milliseconds: 1200),
    ),
  );
}

void successSnakbar(
  context,
  message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Column(
        children: [
          loadAssetPic(
            ImagePathProvider.successSnakbarIcon,
            width: 50,
          ),
          const Text(
            'Success',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: AppColors.grey300,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void failedSnakbar(
  context,
  message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Column(
        children: [
          loadAssetPic(
            ImagePathProvider.failedSnakbarIcon,
            width: 50,
          ),
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: AppColors.grey300,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void warningSnakbar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Column(
        children: [
          loadAssetPic(
            ImagePathProvider.warningSnakbarIcon,
            width: 50,
          ),
          const Text(
            'Warning',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: AppColors.grey300,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
