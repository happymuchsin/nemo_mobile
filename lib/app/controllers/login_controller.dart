import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class LoginController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();
  RxBool secureText = true.obs;
  RxString password = "".obs, deviceType = "".obs;

  TextEditingController nik = TextEditingController();

  void showHide() {
    secureText(!secureText.value);
  }

  Future<void> setPassword(v) async {
    password(v);
  }

  Future<void> login() async {
    EasyLoading.show();
    var user = '';
    localShared.simpan('mode', 'live');
    user = nik.text;
    if (kDebugMode) {
      localShared.simpan('mode', 'local');
    }
    Map<String, dynamic> data = {};
    data['username'] = user.toString();
    data['password'] = password.toString();
    apiReq.login(data);
  }

  @override
  void onReady() {
    super.onReady();
    deviceType(getDevice());
    if (lemparan != null) {
      if (lemparan['koneksi'] == 'gagal') {
        notif('Please check connection');
      }
    }
  }
}
