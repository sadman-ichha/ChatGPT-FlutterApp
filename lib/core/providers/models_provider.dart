import 'package:flutter/cupertino.dart';
import '../../features/views/chat_screen/data/models_model.dart';
import '../services/api_services.dart';

class ModelsProvider extends ChangeNotifier {
  String currentModel ="text-davinci-003" ;

  String? get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel>? modelsList ;

  List<ModelsModel>? get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>?> getAllModels() async {
    modelsList = (await ApiService.getModels())!;
    return modelsList;
  }
}
