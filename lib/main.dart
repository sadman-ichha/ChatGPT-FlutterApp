import 'package:chatgpt/core/constents/font_manager.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:chatgpt/features/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatGPT());
}

class ChatGPT extends StatelessWidget {
  const ChatGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: FontConstants.fontFamily,
        scaffoldBackgroundColor: AppColors.whiteColor,
      ),
      home: const SplashScreen(),
    );
  }
}
