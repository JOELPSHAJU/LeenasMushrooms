import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final Widget? title;
  final Color iconThemeColor;
  final Color backgroundColor;
  final Color surfaceTintColor;
  final bool iconNeeded;

  const CommonAppBar({
    super.key,
    this.toolbarHeight = 70,
    this.title,
    required this.iconNeeded,
    this.iconThemeColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.surfaceTintColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: iconNeeded,
      toolbarHeight: toolbarHeight,
      iconTheme: IconThemeData(color: iconThemeColor),
      centerTitle: true,
      elevation: 5,
      shadowColor: const Color.fromARGB(255, 249, 249, 249),
      title: loadAssetPic(ImagePathProvider.logoletters,
          height: 40), // Default to an empty widget if no title is provided
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
