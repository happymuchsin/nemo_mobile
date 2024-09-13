import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/models/approval_model.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ApprovalController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();
  final dataList = <ApprovalModel>[].obs;
  var deviceType = "".obs, sIdCard = "".obs, sBoxCard = "".obs, idCard = "".obs, boxCard = "".obs, sApproval = "".obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();
  var lIdCard = [].obs, lBoxCard = [].obs;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    awalan();
  }

  void awalan() async {
    getData();
  }

  Future<void> getData() async {
    dataList.clear();
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['username'] = await localShared.baca('username');
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest("$a/approval/data", data, second: 60);
    if (r['success'] == 200) {
      final List<dynamic> res = r['data'];
      dataList(res.map((data) => ApprovalModel.fromJson(data)).toList());
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> approval(status, id) async {
    sApproval(id);
    if (status == 'WAITING') {
      scanIdCard('approval');
    } else if (status == 'APPROVE') {
      scanIdCard('operator');
    } else {
      notif('NEED APPROVAL');
    }
  }

  Future<void> scanIdCard(tipe) async {
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
                    await scanId(tipe);

                    sIdCard.value = '';
                    fIdCard.requestFocus();
                  }
                }
              },
              txt: sIdCard.value),
          cardScan(tipe == 'approval' ? 'Scan ID Card Approval' : 'Scan ID Card Requestor'),
        ],
      ),
      onDismissCallback: (p0) {
        fIdCard.unfocus();
      },
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

  Future<void> scanId(tipe) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sIdCard.value.toString();
    if (kDebugMode) {
      if (tipe == 'approval') {
        data['rfid'] = 'dev';
      } else {
        data['rfid'] = 'ul3c1';
      }
    }
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    data['tipe'] = tipe;
    data['approval'] = sApproval.value;
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      fIdCard.unfocus();
      scanBoxCard();
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
          cardScan('Scan New Box Card'),
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
      data['rfid'] = '00box1';
    }
    data['tipe'] = 'approval';
    data['approval'] = sApproval.value;
    data['username'] = await localShared.baca('username');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      notif(
        r['message'],
        tipe: 'success',
        onDismissCallback: (p0) {
          getData();
        },
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  @override
  void onClose() {
    fIdCard.dispose();
    super.onClose();
  }
}
