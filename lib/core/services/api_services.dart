import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatgpt/core/constents/api_constents.dart';
import 'package:chatgpt/features/views/chat_screen/data/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../features/views/chat_screen/data/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>?> getModels() async {
    String modelApiUrl = "$BASE_URL/models";
    try {
      Response response = await http.get(Uri.parse(modelApiUrl),
          headers: {"Authorization": "Bearer $API_KEY"});

      Map<dynamic, dynamic> jsonResponse = jsonDecode(response.body);

      // log("jsonResponse: $jsonResponse");

      if (jsonResponse["error"] != null) {
        // print("error: ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
        // print("jsonResponse $jsonResponse");

      }

      var temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        log("value : ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      // log("error is : $error");
      rethrow;
    }
  }

// send Message from user
  static Future<List<ChatModel>?> sendMessage(
      {required String message, required String modelId}) async {
    String sendApiUrl = "$BASE_URL/completions";

    try {
      Response response = await http.post(
        Uri.parse(sendApiUrl),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "model": modelId,
          "prompt": message,
          "max_tokens": 500,
        }),
      );

      Map<dynamic, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonError: ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList = [];
      chatList = List.generate(
        jsonResponse["choices"].length,
        (index) => ChatModel(
          msg: jsonResponse["choices"][index]["text"],
          chatIndex: 1,
        ),
      );

      if (jsonResponse["choices"].length > 0) {
        log("send Responseeeeeeeeeee : ${jsonResponse["choices"][0]["text"]}");
      }
    } catch (error) {
      // log("error is : $error");
      rethrow;
    }
  }
}
