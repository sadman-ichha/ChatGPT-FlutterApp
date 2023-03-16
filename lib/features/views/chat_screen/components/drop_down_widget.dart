import 'package:chatgpt/core/global%20widgets/text_widget.dart';
import 'package:chatgpt/core/providers/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelsDrowDownWidget extends StatefulWidget {
  const ModelsDrowDownWidget({super.key});

  @override
  State<ModelsDrowDownWidget> createState() => _ModelsDrowDownWidgetState();
}

class _ModelsDrowDownWidgetState extends State<ModelsDrowDownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final ModelsProvider modelProvider =
        Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelProvider.getCurrentModel;
    return FutureBuilder(
      future: modelProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: TextWidget(
            label: snapshot.error.toString(),
          ));
        }

        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  items: List<DropdownMenuItem<String?>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                        label: snapshot.data![index].id,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                    modelProvider.setCurrentModel(value!);
                  },
                ),
              );
      },
    );
  }
}
