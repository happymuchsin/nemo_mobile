import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class RequestNewNeedleController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var step = "".obs,
      selectedStatus = "".obs,
      sIdCard = "".obs,
      sBoxCard = "".obs,
      deviceType = "".obs,
      idCard = "".obs,
      boxCard = "".obs,
      sTengah = "".obs,
      sBelakang = "".obs,
      sSrf = "".obs;
  var lIdCard = [].obs, lBoxCard = [].obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  var bulan = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
  var tahun = [];

  var tSelectedStatus = TextEditingController();
  var tIdCard = TextEditingController();
  var tUsername = TextEditingController();
  var tName = TextEditingController();
  var tLine = TextEditingController();
  var tStatus = TextEditingController();
  var tRemark = TextEditingController();
  var tDepan = TextEditingController();
  var tBuyer = TextEditingController();
  var tSeason = TextEditingController();
  var tStyle = TextEditingController();
  var tBoxCard = TextEditingController();
  var tBrand = TextEditingController();
  var tTipe = TextEditingController();
  var tSize = TextEditingController();

  var pembantu = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    step(lemparan[0]['step']);
    var month = DateFormat('MMM').format(DateTime.now()).toUpperCase();
    var year = DateFormat('yy').format(DateTime.now());
    for (var i = int.parse(year) + 1; i >= 23; i--) {
      tahun.add(i);
    }
    sTengah(month);
    sBelakang(year);
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

  Future<void> scanId() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sIdCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = 'ul3c1';
    }
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tLine.text = r['data']['line'];
      tIdCard.text = r['data']['rfid'];
      tUsername.text = r['data']['username'];
      tName.text = r['data']['name'];
      person(r['data']);
      idCard(r['data']['rfid']);
      fIdCard.unfocus();
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> changeStatus(status) async {
    selectedStatus(status);
    tSelectedStatus.text = status;
    tRemark.text = '';
  }

  Future<void> next() async {
    if (idCard.value == '') {
      notif('Please scan ID Card');
    } else if (selectedStatus.value == '') {
      notif('Please select Request Status');
    } else if (selectedStatus.value == 'Others' && tRemark.text == '') {
      notif('Please insert Remark');
    } else {
      scanBoxCard();
    }
  }

  Future<void> cari() async {
    tBuyer.text = '';
    tSeason.text = '';
    tStyle.text = '';
    sSrf('');
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['srf'] = tDepan.text + sTengah.value + sBelakang.value;
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/style/get', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      tBuyer.text = r['data']['buyer'];
      tSeason.text = r['data']['season'];
      tStyle.text = r['data']['style'];
      sSrf(r['data']['id'].toString());
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
      data['rfid'] = '00box1';
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
      step('2');
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    if (sSrf.value == '') {
      notif('Please search SRF');
    } else if (boxCard.value == '') {
      notif('Please scan Box Card');
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {};
      data['idCard'] = idCard.value;
      data['boxCard'] = boxCard.value;
      data['style'] = sSrf.value;
      data['needle'] = stock['needle']['id'];
      data['username'] = await localShared.baca('username');
      data['status'] = "REQUEST NEW";
      data['request_status'] = tSelectedStatus.text;
      data['remark'] = tRemark.text;
      data['reff'] = await localShared.baca('reff');
      data['area_id'] = await localShared.bacaInt('area_id');
      data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
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
