
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';

class ScreenRouteTitle extends StatelessWidget {
   ScreenRouteTitle({
    required this.title,this.action,
    super.key,
  });
  final String title;
  VoidCallback? action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Center(
              child: IconButton(
                onPressed:action==null? () => Navigator.pop(context):action,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppFonts.getAppFont(
              context: context,
              size: 21,
              weight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
