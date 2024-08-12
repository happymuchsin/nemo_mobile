import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class LoginController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();
  RxBool secureText = true.obs;
  RxString password = "".obs;

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
    if (nik.text.substring(0, 1).toLowerCase() == '8') {
      localShared.simpan('mode', 'local');
      user = nik.text.substring(1, nik.text.length);
    } else {
      localShared.simpan('mode', 'live');
      user = nik.text;
    }
    // localShared.simpan('mode', 'local');
    Map<String, dynamic> data = {};
    data['username'] = user.toString();
    data['password'] = password.toString();
    apiReq.login(data);
  }

  @override
  void onReady() {
    super.onReady();
    if (lemparan != null) {
      if (lemparan['koneksi'] == 'gagal') {
        notif('Please check connection');
      }
    }
  }
}
