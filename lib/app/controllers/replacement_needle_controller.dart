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

class ReplacementNeedleController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();

  var deviceType = "".obs, sBoxCard = "".obs;
  var lBoxCard = [].obs;
  var fBoxCard = FocusNode();

  var username = TextEditingController();
  var line = TextEditingController();
  var style = TextEditingController();
  var brand = TextEditingController();
  var tipe = TextEditingController();
  var size = TextEditingController();

  var selectedCheckboxIndex = (-1).obs;
  var tulisan = [
    'Replacement',
  ];
  var images = [
    'assets/img/routine.png',
  ].obs;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());

    username.text = lemparan[0]['username'];
    line.text = lemparan[0]['line'];
    style.text = lemparan[0]['style'];
    brand.text = lemparan[0]['brand'];
    tipe.text = lemparan[0]['tipe'];
    size.text = lemparan[0]['size'];
  }

  void selectCheckbox(int index) {
    if (selectedCheckboxIndex.value == index) {
      selectedCheckboxIndex.value = -1; // Unselect if the same checkbox is clicked
    } else {
      selectedCheckboxIndex.value = index;
    }
  }

  Future<void> submit() async {
    if (selectedCheckboxIndex.value == -1) {
      notif('Please select Status');
    } else {
      scanBoxCard();
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
      sBoxCard.value = '00box1';
    }
    if (lemparan[0]['boxCard'] != sBoxCard.value) {
      EasyLoading.dismiss();
      notif('Please scan valid Box');
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {};
      data['approvalId'] = lemparan[0]['approvalId'];
      data['idCard'] = lemparan[0]['idCard'];
      data['line'] = lemparan[0]['lineId'];
      data['style'] = lemparan[0]['styleId'];
      data['boxCard'] = lemparan[0]['boxCard'];
      data['needle'] = lemparan[0]['needleId'];
      data['username'] = await localShared.baca('username');
      data['status'] = tulisan[selectedCheckboxIndex.value];
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
            Get.back();
          },
        );
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    }
  }
}
