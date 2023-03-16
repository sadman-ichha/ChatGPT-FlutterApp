import 'package:chatgpt/core/constents/assets_manager.dart';
import 'package:chatgpt/core/global%20widgets/chat_widget.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
// const ChatScreen({super.key});
  final bool _isTyping = false;

  TextEditingController? _textController;
  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: AppColors.cardColor,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            //radius: 25.0,
            backgroundImage: AssetImage(AppImages.openaiLogo),
          ),
        ),
        title: const Text(
          "ChatGPT",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ChatWidget();
                }),
          ),
          _isTyping
              ? const SpinKitThreeBounce(
                  color: Colors.black,
                  size: 22,
                )
              : const SizedBox.shrink(),
          Card(
            color: Color.fromARGB(255, 230, 222, 222),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "How can I help you Boss",
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.sendLogo,
                      height: 20.0,
                      width: 20.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
