import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ChangeNeedleController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();
  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var lIdCard = [].obs, lBoxCard = [].obs, lBoxReturnCard = [].obs, lApproval = [].obs;
  var deviceType = "".obs,
      step = "".obs,
      idCard = "".obs,
      boxCard = "".obs,
      boxReturnCard = "".obs,
      sIdCard = "".obs,
      sBoxCard = "".obs,
      sTengah = "".obs,
      sBelakang = "".obs,
      sSrf = "".obs,
      sCondition = "".obs,
      sApproval = "".obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  var bulan = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
  var tahun = [];

  var pembantu = TextEditingController();

  var tBoxCard = TextEditingController();
  var tBrand = TextEditingController();
  var tTipe = TextEditingController();
  var tSize = TextEditingController();
  var tIdCard = TextEditingController();
  var tUsername = TextEditingController();
  var tName = TextEditingController();
  var tLine = TextEditingController();
  var tCondition = TextEditingController();
  var tDepan = TextEditingController();
  var tBuyer = TextEditingController();
  var tSeason = TextEditingController();
  var tStyle = TextEditingController();

  var gambar = Rx<File?>(null);

  var scrollController = ScrollController();

  var selectedCheckboxIndex = (-1).obs;
  var tulisan = [
    'Deformed',
    'Routine Change',
    'Change Style or Material',
    'Broken Missing Fragment',
  ];
  var images = [
    'assets/img/deformed.png',
    'assets/img/routine.png',
    'assets/img/change.png',
    'assets/img/broken.png',
  ].obs;

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
    spinner('approval', '');
    scanIdCard();
  }

  Future<void> spinner(tipe, x) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    var a = await apiReq.baseUrl();
    data['x'] = x;
    data['area_id'] = await localShared.bacaInt('area_id');
    data['username'] = await localShared.baca('username');
    if (tipe == 'approval') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lApproval(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else {
      lApproval();
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
      data['rfid'] = 'ul2c2';
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

  void selectCheckbox(int index) {
    if (selectedCheckboxIndex.value == index) {
      selectedCheckboxIndex.value = -1; // Unselect if the same checkbox is clicked
    } else {
      selectedCheckboxIndex.value = index;
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

  Future<void> addImage(mode, tipe, {id}) async {
    final x = await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    if (x != null) {
      if (tipe == 'gambar') {
        gambar.value = File(x.path);
      }
    }
  }

  Future<void> changeCondition(x) async {
    if (idCard.value == '') {
      notif('Please scan ID Card');
    } else if (gambar.value == null) {
      notif('Please take a Picture');
    } else if (selectedCheckboxIndex.value == -1) {
      notif('Please select Change Option');
    } else {
      sCondition(x);
      tCondition.text = x;
      if (x == 'Missing Fragment') {
        step('3');
      } else {
        if (x == 'Good') {
          scanBoxCard('return');
        } else {
          scanBoxCard('normal');
        }
        step('2');
      }
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );

      tDepan.text = '';
      tBuyer.text = '';
      tSeason.text = '';
      tStyle.text = '';
      sSrf.value = '';
    }
  }

  Future<void> scanBoxCard(tipe) async {
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
                    await scanBox(tipe);

                    sBoxCard.value = '';
                    fBoxCard.requestFocus();
                  }
                }
              },
              txt: sBoxCard.value),
          cardScan(tipe == 'return' ? 'Scan Box Return Card' : 'Scan Box Card'),
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

  Future<void> scanBox(tipe) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sBoxCard.value.toString();
    if (kDebugMode) {
      if (tipe == 'return') {
        data['rfid'] = '00box2';
      } else {
        data['rfid'] = '00box1';
      }
    }
    data['tipe'] = tipe;
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      if (tipe == 'return') {
        boxReturnCard(r['data']['box']['rfid']);
        scanBoxCard('normal');
      } else {
        tBoxCard.text = r['data']['box']['rfid'];
        tBrand.text = r['data']['stock']['needle']['brand'];
        tTipe.text = r['data']['stock']['needle']['tipe'];
        tSize.text = r['data']['stock']['needle']['size'];
        box(r['data']['box']);
        stock(r['data']['stock']);
        boxCard(r['data']['box']['rfid']);
      }
      step('2');
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    var next = 'not';
    if (sSrf.value == '') {
      notif('Please search SRF');
    } else {
      if (sCondition.value != 'Missing Fragment') {
        if (boxCard.value == '') {
          notif('Please scan Box Card');
        } else if (sCondition.value == 'Good' && boxReturnCard.value == '') {
          notif('Please scan Box Return Card');
        } else {
          next = 'yes';
        }
      } else {
        next = 'yes';
      }
    }

    if (next == 'yes') {
      EasyLoading.show();
      List<int> imageBytes = File(gambar.value!.path).readAsBytesSync();
      Map<String, dynamic> data = {};
      data['idCard'] = idCard.value;
      data['style'] = sSrf.value;
      data['boxCard'] = boxCard.value;
      data['boxReturnCard'] = boxReturnCard.value;
      data['needle'] = stock['needle'] != null ? stock['needle']['id'] : null;
      data['username'] = await localShared.baca('username');
      data['filename'] = gambar.value!.path.split('/').last;
      data['ext'] = gambar.value!.path.split('.').last;
      data['gambar'] = base64Encode(imageBytes);
      data['status'] = tulisan[selectedCheckboxIndex.value];
      data['condition'] = sCondition.value;
      data['approval'] = sApproval.value;
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
