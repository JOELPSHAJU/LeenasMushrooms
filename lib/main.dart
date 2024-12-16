import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leenas_mushrooms/widgets/main_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientation to portrait up
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leenas Mushrooms',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TextClass(),
    );
  }
}

class TextClass extends StatelessWidget {
  const TextClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: MainButton(
            buttonText: '',
          ),
        ),
      ),
    );
  }
}
