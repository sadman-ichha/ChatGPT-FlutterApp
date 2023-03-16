import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/core/constents/assets_manager.dart';
import 'package:chatgpt/core/global%20widgets/sizedbox.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:chatgpt/features/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(AppImages.openaiLogo),
              ),
              20.ph,
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Hello world!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                // totalRepeatCount: 4,
                // pause: const Duration(milliseconds: 1000),
                // displayFullTextOnTap: true,
                // stopPauseOnTap: true,
              )
            ],
          ),
        ));
  }
}
