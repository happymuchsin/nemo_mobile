import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/models/approval_model.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ApprovalController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();
  final dataList = <ApprovalModel>[].obs;
  var deviceType = "".obs, sIdCard = "".obs;
  var fIdCard = FocusNode();
  var lIdCard = [].obs;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    awalan();
  }

  void awalan() async {
    getData();

    Future.delayed(const Duration(milliseconds: 50), () {
      fIdCard.requestFocus();
    });
  }

  Future<void> getData() async {
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
    data['tipe'] = 'approval';
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      btnStatus(
        r['data']['id'],
        r['data']['status'],
        r['data']['idCard'],
        r['data']['username'],
        r['data']['line'],
        r['data']['lineId'],
        r['data']['style'],
        r['data']['styleId'],
        r['data']['brand'],
        r['data']['tipe'],
        r['data']['size'],
        r['data']['boxCard'],
        r['data']['needleId'],
        r['data']['gambar'],
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
    Future.delayed(const Duration(milliseconds: 50), () {
      fIdCard.requestFocus();
    });
  }

  Future<void> btnStatus(id, x, idCard, username, line, lineId, style, styleId, brand, tipe, size, boxCard, needleId, gambar) async {
    if (x == 'WAITING') {
      notif('NEED APPROVAL');
    } else if (x == 'REJECT') {
      notif('ITS REJECT');
    } else {
      Map<String, dynamic> args = {};
      args['title'] = "Approval\nReplacement Needle";
      args['halaman'] = "replacement-needle";
      args['approvalId'] = id;
      args['idCard'] = idCard;
      args['username'] = username;
      args['line'] = line;
      args['lineId'] = lineId;
      args['style'] = style;
      args['styleId'] = styleId;
      args['brand'] = brand;
      args['tipe'] = tipe;
      args['size'] = size;
      args['boxCard'] = boxCard;
      args['needleId'] = needleId;
      args['gambar'] = gambar;
      final result = await Get.toNamed(Routes.replacementNeedle, arguments: [args]);

      if (result == 'refresh') {
        dataList.clear();
        getData();
        Future.delayed(const Duration(milliseconds: 50), () {
          fIdCard.requestFocus();
        });
      }
    }
  }

  @override
  void onClose() {
    fIdCard.dispose();
    super.onClose();
  }
}
