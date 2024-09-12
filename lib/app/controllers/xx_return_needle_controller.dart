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

class ReturnNeedleController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs;
  var deviceType = "".obs,
      sIdCard = "".obs,
      sBoxCard = "".obs,
      sBuyer = "".obs,
      sStyle = "".obs,
      sSrf = "".obs,
      sBrand = "".obs,
      sTipe = "".obs,
      sSize = "".obs,
      sCode = "".obs;
  var lBuyer = [].obs, lStyle = [].obs, lSrf = [].obs, lBrand = [].obs, lTipe = [].obs, lSize = [].obs, lCode = [].obs;

  var username = TextEditingController();
  var line = TextEditingController();
  var boxCard = TextEditingController();
  var boxName = TextEditingController();
  var boxStatus = TextEditingController();

  var pembantu = TextEditingController();

  XFile? gambar;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());

    person(lemparan['person']);
    box(lemparan['box']);
    sIdCard(lemparan['idCard']);
    sBoxCard(lemparan['boxCard']);
    gambar = lemparan['gambar'];
    username.text = person['username'];
    line.text = person['line'];
    boxCard.text = box['rfid'];
    boxName.text = box['name'];
    boxStatus.text = box['status'];

    spinner('buyer', '');
    spinner('brand', '');
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
    } else if (tipe == 'brand') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lBrand(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'tipe') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lTipe(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'size') {
      data['tipe'] = tipe;
      data['brand'] = sBrand.value;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lSize(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'code') {
      data['tipe'] = tipe;
      data['brand'] = sBrand.value;
      data['type'] = sTipe.value;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lCode(r['data']);
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
      lBrand();
      lTipe();
      lSize();
      lCode();
    }
  }

  Future<void> submit() async {
    if (sBuyer.value == '') {
      notif('Please select Buyer');
    } else if (sStyle.value == '') {
      notif('Please select Style');
    } else if (sSrf.value == '') {
      notif('Please select SRF');
    } else if (sBrand.value == '') {
      notif('Please select Brand');
    } else if (sTipe.value == '') {
      notif('Please select Type');
    } else if (sSize.value == '') {
      notif('Please select Size');
    } else if (sCode.value == '') {
      notif('Please select Code');
    } else {
      EasyLoading.show();
      List<int> imageBytes = File(gambar!.path).readAsBytesSync();
      Map<String, dynamic> data = {};
      data['status'] = 'RETURN';
      data['idCard'] = sIdCard.value;
      data['style'] = sSrf.value;
      // data['brand'] = sBrand.value;
      // data['tipe'] = sTipe.value;
      // data['size'] = sSize.value;
      data['needle'] = sCode.value;
      data['boxCard'] = sBoxCard.value;
      data['username'] = await localShared.baca('username');
      data['filename'] = gambar!.name.toString();
      data['ext'] = gambar!.path.split('.').last;
      data['gambar'] = base64Encode(imageBytes);
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
