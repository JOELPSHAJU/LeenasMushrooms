import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/widgets/main_button.dart';
import 'package:leenas_mushrooms/widgets/text_field.dart';

class MobileLoginPage extends StatelessWidget {
  const MobileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final passController = TextEditingController();

    // Using ValueNotifier to manage password visibility state
    final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          // Bottom container with rounded top radius
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 407, // Adjust height
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back !",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    TExtField(
                      hintText: 'Enter username',
                      controller: userController,
                      obscureText: false,
                      prefixIcon: Icons.person,
                    ),
                    // const SizedBox(height: 8),
                    ValueListenableBuilder<bool>(
                      valueListenable: isPasswordVisible,
                      builder: (context, isVisible, child) {
                        return TExtField(
                          hintText: 'Enter Password',
                          controller: passController,
                          obscureText: !isVisible,
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            onPressed: () {
                              isPasswordVisible.value = !isVisible;
                            },
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: isVisible ? Colors.grey : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    MainButton(buttonText: "Login", onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
