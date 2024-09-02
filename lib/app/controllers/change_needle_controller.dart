import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ChangeNeedleController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();
  var lBuyer = [].obs, lStyle = [].obs, lSrf = [].obs;
  var deviceType = "".obs, sIdCard = "".obs, sBoxCard = "".obs, sBuyer = "".obs, sStyle = "".obs, sSrf = "".obs;

  var person = {}.obs, box = {}.obs, stock = {}.obs;

  var pembantu = TextEditingController();
  var username = TextEditingController();
  var line = TextEditingController();
  var brand = TextEditingController();
  var tipe = TextEditingController();
  var size = TextEditingController();

  XFile? gambar;

  var selectedCheckboxIndex = (-1).obs;
  var tulisan = [
    'Broken',
    'Deformed',
    'Routine Needle Exchange',
    'Change Style or Material',
  ];
  var images = [
    'assets/img/broken.png',
    'assets/img/deformed.png',
    'assets/img/routine.png',
    'assets/img/change.png',
  ].obs;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());

    person(lemparan['person']);
    box(lemparan['box']);
    stock(lemparan['stock']);
    sIdCard(lemparan['idCard']);
    sBoxCard(lemparan['boxCard']);
    gambar = lemparan['gambar'];

    username.text = person['username'];
    line.text = person['line'];
    brand.text = stock['needle']['brand'];
    tipe.text = stock['needle']['tipe'];
    size.text = stock['needle']['size'];

    spinner('buyer', '');
  }

  void selectCheckbox(int index) {
    if (selectedCheckboxIndex.value == index) {
      selectedCheckboxIndex.value = -1; // Unselect if the same checkbox is clicked
    } else {
      selectedCheckboxIndex.value = index;
    }
  }

  Future<void> spinner(tipe, x) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    var a = await apiReq.baseUrl();
    data['x'] = x;
    data['area_id'] = await localShared.bacaInt('area_id');
    data['username'] = await localShared.baca('username');
    if (tipe == 'buyer') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lBuyer(r['data']);
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
        sStyle('');
        sSrf('');
        lStyle(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'srf') {
      data['tipe'] = tipe;
      data['buyer'] = sBuyer.value;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        sSrf('');
        lSrf(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else {
      lBuyer();
      lStyle();
      lSrf();
    }
  }

  Future<void> submit() async {
    if (sBuyer.value == '') {
      notif('Please select Buyer');
    } else if (sStyle.value == '') {
      notif('Please select Style');
    } else if (sSrf.value == '') {
      notif('Please select SRF');
    } else if (selectedCheckboxIndex.value == -1) {
      notif('Please select Status');
    } else {
      EasyLoading.show();
      List<int> imageBytes = File(gambar!.path).readAsBytesSync();
      Map<String, dynamic> data = {};
      data['idCard'] = sIdCard.value;
      data['style'] = sSrf.value;
      data['boxCard'] = sBoxCard.value;
      data['needle'] = stock['needle']['id'];
      data['username'] = await localShared.baca('username');
      data['filename'] = gambar!.name.toString();
      data['ext'] = gambar!.path.split('.').last;
      data['gambar'] = base64Encode(imageBytes);
      data['status'] = tulisan[selectedCheckboxIndex.value];
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
