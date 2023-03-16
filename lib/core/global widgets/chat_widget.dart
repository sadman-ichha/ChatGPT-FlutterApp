import 'package:chatgpt/core/constents/assets_manager.dart';
import 'package:chatgpt/core/global%20widgets/text_widget.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key, required this.chatMassage, required this.chatIndex});

  final String chatMassage;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2,
          color: chatIndex == 0
              ? AppColors.whiteColor
              : AppColors.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                    width: 30.0,
                    height: 30.0,
                    chatIndex == 0 ? AppImages.manImg : AppImages.botImage),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextWidget(
                    label: chatMassage,
                  ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.thumb_down_alt_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
