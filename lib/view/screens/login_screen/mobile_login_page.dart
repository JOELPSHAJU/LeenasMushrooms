import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/textformfield.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/text_constants.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/home_screen/dashboard/home_page.dart';
import 'package:leenas_mushrooms/view/screens/home_screen/widgets/main_button.dart';

class MobileLoginPage extends StatelessWidget {
  const MobileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            loadAssetPic(ImagePathProvider.loginBackgroundImage,
                width: size.width, height: size.height * .8, fit: BoxFit.cover),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * .36.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.all(25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppText.welcome,
                        style: AppFonts.getAppFont(
                            context: context,
                            weight: FontWeight.w500,
                            size: 16.sp,
                            color: Colors.grey.shade500),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommonTextformField(
                          maxlines: 1,
                          enabled: true,
                          fillColor: AppColors.white,
                          hintText: AppText.enterEmail,
                          prefixwidget: Icon(
                            Icons.person,
                            size: 20.w,
                          ),
                          controller: userNameController),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommonTextformField(
                          maxlines: 1,
                          enabled: true,
                          fillColor: AppColors.white,
                          hintText: AppText.enterPassword,
                          prefixwidget: Icon(
                            Icons.security,
                            size: 20.w,
                          ),
                          controller: passWordController),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const HomePage()));
                          },
                          child: const MainButton(buttonText: 'Login'))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
