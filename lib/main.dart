import 'package:chatgpt/core/constents/font_manager.dart';
import 'package:chatgpt/core/providers/chat_provider.dart';
import 'package:chatgpt/core/providers/models_provider.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:chatgpt/features/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ModelsProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ChatProvider()),
        ),
      ],
      child: const ChatGPT(),
    ),
  );
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
