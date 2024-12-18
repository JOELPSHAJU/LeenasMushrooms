import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/widgets/main_button.dart';
import 'package:leenas_mushrooms/widgets/text_field.dart';

class MobileLoginPage extends StatelessWidget {
  const MobileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();
    final Size size = MediaQuery.of(context).size;

    // Using ValueNotifier to manage password visibility state
    final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/login_background.png",
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * .43,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            fontSize: 16),
                      ),
                      CommonTextField(
                          hintText: 'Enter email',
                          prefixIcon: Icons.person,
                          controller: userNameController),
                      CommonTextField(
                          hintText: 'Enter email',
                          prefixIcon: Icons.security,
                          controller: passWordController),
                      const SizedBox(
                        height: 20,
                      ),
                      const MainButton(buttonText: 'Login')
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
