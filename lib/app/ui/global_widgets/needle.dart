import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

final apiReq = Api();
final localShared = LocalShared();

Future<Map<String, dynamic>> spinner(tipe, x) async {
  EasyLoading.show();
  Map<String, dynamic> data = {};
  Map<String, dynamic> balikan = {};
  var a = await apiReq.baseUrl();
  data['x'] = x;
  data['area_id'] = await localShared.bacaInt('area_id');
  data['username'] = await localShared.baca('username');
  if (tipe == 'line') {
    data['tipe'] = tipe;
    var r = await apiReq.makeRequest("$a/spinner", data);
    if (r['success'] == 200) {
      balikan['data'] = r['data'];
    } else if (r['success'] == 423) {
      balikan['data'] = [];
    } else {
      balikan['notif'] = r['message'];
    }
  } else if (tipe == 'style') {
    data['tipe'] = tipe;
    var r = await apiReq.makeRequest("$a/spinner", data);
    if (r['success'] == 200) {
      balikan['data'] = r['data'];
    } else if (r['success'] == 423) {
    } else {
      balikan['notif'] = r['message'];
    }
  } else {
    balikan['data'] = [];
  }

  EasyLoading.dismiss();
  return balikan;
}

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
