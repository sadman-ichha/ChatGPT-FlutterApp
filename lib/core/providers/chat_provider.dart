import 'package:chatgpt/features/views/chat_screen/data/chat_model.dart';
import 'package:flutter/cupertino.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
 List<ChatModel> get getChatList {
    return chatList;
  }

  void addMessage({required String meassage}) {
    chatList.add(ChatModel(msg: meassage, chatIndex: 0));
    notifyListeners();
  }

  // Future<void> sendMessageANDgetAns(
  //     {required String message, required String choseneModelId}) async {
  //   chatList.addAll(await ApiService.sendMessage(
  //     message: message,
  //     modelId: choseneModelId,
  //   ));
  // }

  Future<void> sendMessageANDgetAns(
      {required String message, required String chosenModelId}) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      chatList.addAll(await ApiService.sendMessage(
        message: message,
        modelId: chosenModelId,
      ));
    } else {
      chatList.addAll(await ApiService.sendMessage(
        message: message,
        modelId: chosenModelId,
      ));
    }
    notifyListeners();
  }
}
