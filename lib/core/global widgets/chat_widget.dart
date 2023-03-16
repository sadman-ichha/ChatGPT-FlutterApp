import 'package:chatgpt/core/constents/assets_manager.dart';
import 'package:chatgpt/core/global%20widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(AppImages.manImg, width: 30.0, height: 30.0),
            10.pw,
            Text("Sadman"),
          ],
        )
      ],
    );
  }
}
