import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class RequestNewNeedleController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var sIdCard = "".obs, sBoxCard = "".obs, deviceType = "".obs, idCard = "".obs, boxCard = "".obs, sLine = "".obs, sStyle = "".obs;
  var lIdCard = [].obs, lBoxCard = [].obs, lLine = [].obs, lStyle = [].obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  var tIdCard = TextEditingController();
  var tUsername = TextEditingController();
  var tName = TextEditingController();
  var tBoxCard = TextEditingController();
  var tBrand = TextEditingController();
  var tTipe = TextEditingController();
  var tSize = TextEditingController();

  var pembantu = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    spinner('line', '');
    spinner('style', '');
    scanIdCard();
  }

  Future<void> spinner(tipe, x) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    var a = await apiReq.baseUrl();
    data['x'] = x;
    data['area_id'] = await localShared.bacaInt('area_id');
    data['username'] = await localShared.baca('username');
    if (tipe == 'line') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lLine(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'style') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lStyle(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else {
      lLine();
      lStyle();
    }
  }

  Future<void> scanIdCard() async {
    Future.delayed(const Duration(milliseconds: 50), () {
      fIdCard.requestFocus();
    });
    dialogCustomBody(
      type: DialogType.noHeader,
      widget: Column(
        children: [
          focusScan(
              fCard: fIdCard,
              kCard: kIdCard,
              onFocusChange: (value) async {
                if (value) {
                  sIdCard('');
                }

                if (!value) {
                  if (sIdCard.value != '') {
                    await scanId();

                    sIdCard.value = '';
                    fIdCard.requestFocus();
                  }
                }
              },
              txt: sIdCard.value),
          cardScan('Scan ID Card'),
        ],
      ),
      // onDismissCallback: (p0) {
      //   fIdCard.unfocus();
      // },
      dismissOnTouchOutside: true,
    );
  }

  KeyEventResult kIdCard(FocusNode node, KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        sIdCard(lIdCard.join().toString());
        lIdCard.clear();
        fIdCard.unfocus();
      } else {
        lIdCard.add(event.character.toString());
      }
    }

    return event.logicalKey == LogicalKeyboardKey.enter ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  Future<void> scanId() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sIdCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = '0006593697';
    }
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tIdCard.text = r['data']['rfid'];
      tUsername.text = r['data']['username'];
      tName.text = r['data']['name'];
      person(r['data']);
      idCard(r['data']['rfid']);
      dialogCustomBody(
        width: Get.width * .5,
        type: DialogType.noHeader,
        widget: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ' : ${person['username']}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ' : ${person['name']}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        onDismissCallback: (p0) {
          fIdCard.unfocus();
          scanBoxCard();
        },
        dismissOnTouchOutside: true,
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> scanBoxCard() async {
    Future.delayed(const Duration(milliseconds: 50), () {
      fBoxCard.requestFocus();
    });
    dialogCustomBody(
      type: DialogType.noHeader,
      widget: Column(
        children: [
          focusScan(
              fCard: fBoxCard,
              kCard: kBoxCard,
              onFocusChange: (value) async {
                if (value) {
                  sBoxCard('');
                }

                if (!value) {
                  if (sBoxCard.value != '') {
                    await scanBox();

                    sBoxCard.value = '';
                    fBoxCard.requestFocus();
                  }
                }
              },
              txt: sBoxCard.value),
          cardScan('Scan Box Card'),
        ],
      ),
      onDismissCallback: (p0) {
        fBoxCard.unfocus();
      },
      dismissOnTouchOutside: true,
    );
  }

  KeyEventResult kBoxCard(FocusNode node, KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        sBoxCard(lBoxCard.join().toString());
        lBoxCard.clear();
        fBoxCard.unfocus();
      } else {
        lBoxCard.add(event.character.toString());
      }
    }

    return event.logicalKey == LogicalKeyboardKey.enter ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  Future<void> scanBox() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sBoxCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = '0010754220';
    }
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tBoxCard.text = r['data']['box']['rfid'];
      tBrand.text = r['data']['stock']['needle']['brand'];
      tTipe.text = r['data']['stock']['needle']['tipe'];
      tSize.text = r['data']['stock']['needle']['size'];
      box(r['data']['box']);
      stock(r['data']['stock']);
      boxCard(r['data']['box']['rfid']);
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    if (sLine.value == '') {
      notif('Please select Line');
    } else if (sStyle.value == '') {
      notif('Please select Style');
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {};
      data['idCard'] = idCard.value;
      data['line'] = sLine.value;
      data['style'] = sStyle.value;
      data['boxCard'] = boxCard.value;
      data['needle'] = stock['needle']['id'];
      data['username'] = await localShared.baca('username');
      data['status'] = "REQUEST NEW";
      var a = await apiReq.baseUrl();
      var r = await apiReq.makeRequest("$a/needle/save", data, second: 60);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        notif(
          r['message'],
          tipe: 'success',
          onDismissCallback: (p0) {
            Get.back();
          },
        );
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    }
  }

  @override
  void onClose() {
    fIdCard.dispose();
    fBoxCard.dispose();
    super.onClose();
  }
}
