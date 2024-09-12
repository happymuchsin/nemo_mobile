import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

final apiReq = Api();
final localShared = LocalShared();

Widget focusScan(
    {required FocusNode fCard, required KeyEventResult Function(FocusNode, KeyEvent) kCard, required Function(bool) onFocusChange, required txt}) {
  return Focus(
    focusNode: fCard,
    onKeyEvent: kCard,
    onFocusChange: onFocusChange,
    child: Visibility(
      visible: false,
      child: TextFormField(
        controller: TextEditingController(text: txt),
        keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          labelText: "RFID",
          labelStyle: TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}

Widget cardScan(txt) {
  return Card(
    elevation: 50,
    shadowColor: Colors.black,
    color: Colors.white,
    child: SizedBox(
      width: double.maxFinite,
      height: Get.height * .5,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                FontAwesomeIcons.nfcDirectional,
                size: getDevice() == 'tablet' ? 200 : 50,
              ),
              Text(
                txt,
                style: const TextStyle(fontSize: 45),
              ),
            ],
          )),
    ),
  );
}
