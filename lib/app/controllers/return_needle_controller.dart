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

class ReturnNeedleController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var sIdCard = "".obs,
      sBoxCard = "".obs,
      deviceType = "".obs,
      idCard = "".obs,
      boxCard = "".obs,
      sLineId = "".obs,
      sStyleId = "".obs,
      sNeedleId = "".obs;
  var lIdCard = [].obs, lBoxCard = [].obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  var tIdCard = TextEditingController();
  var tUsername = TextEditingController();
  var tName = TextEditingController();
  var tLine = TextEditingController();
  var tStyle = TextEditingController();
  var tBoxCard = TextEditingController();
  var tBoxName = TextEditingController();
  var tBrand = TextEditingController();
  var tTipe = TextEditingController();
  var tSize = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    scanIdCard();
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
    data['tipe'] = 'return';
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tIdCard.text = r['data']['user']['rfid'];
      tUsername.text = r['data']['user']['username'];
      tName.text = r['data']['user']['name'];
      tBoxCard.text = r['data']['needle']['box']['rfid'];
      tBoxName.text = r['data']['needle']['box']['name'];
      tLine.text = r['data']['needle']['line']['name'];
      sLineId.value = r['data']['needle']['line']['id'].toString();
      tStyle.text = r['data']['needle']['style']['name'];
      sStyleId.value = r['data']['needle']['style']['id'].toString();
      sNeedleId.value = r['data']['needle']['needle']['id'].toString();
      tBrand.text = r['data']['needle']['needle']['brand'];
      tTipe.text = r['data']['needle']['needle']['tipe'];
      tSize.text = r['data']['needle']['needle']['size'];
      person(r['data']['user']);
      idCard(r['data']['user']['rfid']);
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
    if (kDebugMode) {
      sBoxCard.value = '0010754220';
    }
    if (tBoxCard.text != sBoxCard.value) {
      EasyLoading.dismiss();
      notif('Please scan valid Box');
    } else {
      Map<String, dynamic> data = {};
      data['idCard'] = idCard.value;
      data['line'] = sLineId.value;
      data['style'] = sStyleId.value;
      data['boxCard'] = sBoxCard.value;
      data['needle'] = sNeedleId.value;
      data['username'] = await localShared.baca('username');
      data['status'] = "RETURN";
      var a = await apiReq.baseUrl();
      var r = await apiReq.makeRequest("$a/needle/save", data, second: 60);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        xdialog.dismiss();
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
