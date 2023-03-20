import 'package:flutter/material.dart';
import '../../../../core/global widgets/text_widget.dart';
import 'drop_down_widget.dart';

class ChatComponents {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 7.0, top: 18.0, bottom: 18.0),
                child: TextWidget(label: "Choose Model:", fontSize: 17),
              ),
              SizedBox(width: 7.0),
              Flexible(
                child: ModelsDrowDownWidget(),
              ),
            ],
          );
        });
  }

//   static List<DropdownMenuItem<String?>>? modelsItems =
//       List<DropdownMenuItem<String?>>.generate(
//     models.length,
//     (index) => DropdownMenuItem(
//       value: models[index],
//       child: TextWidget(
//         label: models[index],
//         fontSize: 16,
//       ),
//     ),
//   );
}
