import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_validators.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/snakbars.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/constants/text_constants.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/bloc/login_bloc/login_bloc.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';

class MobileLoginPage extends StatelessWidget {
  const MobileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    final loginFormKey = GlobalKey<FormState>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          successSnakbar(
            context,
            "Login Sucessful",
          );
          Navigator.push(
              context, CupertinoPageRoute(builder: (c) => MainScreen()));
        } else if (state is LoginFailure) {
          failedSnakbar(context, 'Login Failed');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              loadAssetPic(ImagePathProvider.loginBackgroundImage,
                  width: size.width,
                  height: size.height * .8,
                  fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: size.height * .43,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h20,
                        CommonTextformField(
                            fieldName: 'UserName',
                            maxlines: 1,
                            enabled: true,
                            validator: validateUsername,
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
                            validator: validateUsername,
                            fillColor: AppColors.white,
                            hintText: AppText.enterPassword,
                            prefixwidget: Icon(
                              Icons.security,
                              size: 20.w,
                            ),
                            controller: passWordController),
                        h30,
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          if (state is LoginLoading) {
                            return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: loadingButton(
                                    media: size,
                                    onPressed: () {},
                                    color: AppColors.black));
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: GestureDetector(
                                onTap: () {
                                  if (loginFormKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                            username: userNameController.text,
                                            password: passWordController.text));
                                  } else {
                                    warningSnakbar(
                                      context,
                                      "Please fill the fields",
                                    );
                                  }
                                },
                                child: const MainButton(buttonText: 'Login')),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
