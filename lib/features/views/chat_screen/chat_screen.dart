import 'package:chatgpt/core/constents/assets_manager.dart';
import 'package:chatgpt/core/global%20widgets/chat_widget.dart';
import 'package:chatgpt/core/global%20widgets/text_widget.dart';
import 'package:chatgpt/core/providers/chat_provider.dart';
import 'package:chatgpt/core/themes/app_colors.dart';
import 'package:chatgpt/features/views/chat_screen/components/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late FocusNode focusNode;
  late ScrollController _listScrollController;
  TextEditingController? _textController;
  @override
  void initState() {
    _textController = TextEditingController();
    focusNode = FocusNode();
    _listScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textController!.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMeassge(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    //Check the Message is empty
    if (_textController!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.cardColor,
        duration: Duration(milliseconds: 800),
        content: TextWidget(
          label: "Message is empty",
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w300,
        ),
      ));
      return;
    }
    //Check the send multiple messages at a time
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: TextWidget(
          label: "can't send multiple messages at a time",
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ));
      return;
    }

    try {
      setState(() {
        _isTyping = true;
        chatProvider.addMessage(meassage: _textController!.text);

        focusNode.unfocus();
      });
      await chatProvider.sendMessageANDgetAns(
        message: _textController!.text,
        chosenModelId: modelsProvider.getCurrentModel,
      );

      setState(() {
        _textController!.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: TextWidget(label: "$e"),
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        scrollListToEnd();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
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
        actions: [
          IconButton(
            onPressed: () async {
              await ChatComponents.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatProvider.chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatMassage: chatProvider.getChatList[index].msg,
                    chatIndex: chatProvider.getChatList[index].chatIndex,
                  );
                }),
          ),
          _isTyping == true
              ? const SpinKitThreeBounce(
                  color: Colors.black,
                  size: 22,
                )
              : const SizedBox.shrink(),
          Card(
            color: const Color.fromARGB(255, 230, 222, 222),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: focusNode,
                      onSubmitted: (value) async {
                        await sendMeassge(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      decoration: const InputDecoration.collapsed(
                        hintText: "Message here",
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await sendMeassge(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider,
                      );
                    },
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
