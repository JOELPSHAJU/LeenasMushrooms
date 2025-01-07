import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/textformfield.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/constants/text_constants.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';

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
                height: size.height * .43,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h20,
                    CommonTextformField(
                        fieldName: 'UserName',
                        maxlines: 1,
                        enabled: true,
                        fillColor: AppColors.white,
                        hintText: AppText.enterEmail,
                        prefixwidget: Icon(
                          Icons.person,
                          size: 20.w,
                        ),
                        controller: userNameController),
                    CommonTextformField(
                        fieldName: 'Password',
                        maxlines: 1,
                        enabled: true,
                        fillColor: AppColors.white,
                        hintText: AppText.enterPassword,
                        prefixwidget: Icon(
                          Icons.security,
                          size: 20.w,
                        ),
                        controller: passWordController),
                    h30,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => MainScreen()));
                          },
                          child: const MainButton(buttonText: 'Login')),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
