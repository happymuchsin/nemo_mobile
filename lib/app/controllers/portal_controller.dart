import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/models/portal_model.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';
import 'package:permission_handler/permission_handler.dart';

class PortalController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();
  var mode = "".obs, username = "".obs, deviceType = "".obs;
  var bChangeNeedle = false.obs,
      bMissingFragment = false.obs,
      bApproval = false.obs,
      bReturnNeedle = false.obs,
      bRequestNewNeedle = false.obs,
      bNeedleStock = false.obs;

  var dataModel = <PortalModel>[].obs;

  Future<String> initialize() async {
    EasyLoading.show(status: 'Please wait check connection to server');
    mode(await localShared.baca('mode'));
    var a = await apiReq.testApi(mode);
    if (a == 'berhasil') {
      username(await localShared.baca('username'));
      if (username.value == '') {
        EasyLoading.dismiss();
        return 'not';
      } else {
        EasyLoading.dismiss();
        return 'yes';
      }
    } else {
      EasyLoading.dismiss();
      return 'gagal';
    }
  }

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    awalan();
  }

  void awalan() async {
    var a = await initialize();
    if (a == 'yes') {
      await checkPermission();

      bChangeNeedle(true);
      bMissingFragment(true);
      bApproval(true);
      bReturnNeedle(true);
      bRequestNewNeedle(true);
      bNeedleStock(true);

      dataModel.add(PortalModel(
          route: Routes.scanCaptureBox,
          name: 'Change Needle',
          tipe: 'image',
          source: 'assets/img/changeNeedle.png',
          visible: bChangeNeedle.value,
          args: {
            'dari': 'change-needle',
            'title': "Change Needle\nScan and Camera Capture",
            'halaman': 'scan-camera-capture-box',
          }));
      dataModel.add(PortalModel(
          route: Routes.missingFragment,
          name: 'Missing Fragment',
          tipe: 'image',
          source: 'assets/img/missingFragment.png',
          visible: bMissingFragment.value));
      dataModel
          .add(PortalModel(route: Routes.approval, name: 'Approval', tipe: 'image', source: 'assets/img/approval.png', visible: bApproval.value));
      dataModel.add(PortalModel(
          route: Routes.returnNeedle, name: 'Return Needle', tipe: 'image', source: 'assets/img/returnNeedle.png', visible: bReturnNeedle.value));
      dataModel.add(PortalModel(
          route: Routes.requestNewNeedle,
          name: 'Request New Needle',
          tipe: 'image',
          source: 'assets/img/requestNewNeedle.png',
          visible: bRequestNewNeedle.value));
      dataModel.add(PortalModel(
          route: Routes.needleStock, name: 'Needle Stock', tipe: 'image', source: 'assets/img/needleStock.png', visible: bNeedleStock.value));
    } else {
      var args = {};
      if (a != 'not') {
        args['koneksi'] = 'gagal';
      }
      Get.offAllNamed(Routes.login, arguments: args);
    }
  }

  Future<void> checkPermission() async {
    PermissionStatus photoStatus = await Permission.photos.status;
    if (!photoStatus.isGranted) {
      // Jika belum diberikan, minta izin
      await Permission.photos.request();
    }
    PermissionStatus storageStatus = await Permission.manageExternalStorage.status;
    if (!storageStatus.isGranted) {
      // Jika belum diberikan, minta izin
      await Permission.manageExternalStorage.request();
    } else if (storageStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    // PermissionStatus locationStatus = await Permission.location.status;
    // if (!locationStatus.isGranted) {
    //   await Permission.location.request();
    // } else if (locationStatus.isPermanentlyDenied) {
    //   openAppSettings();
    // }
    // PermissionStatus locationAlwaysStatus = await Permission.locationAlways.status;
    // if (!locationAlwaysStatus.isGranted) {
    //   await Permission.locationAlways.request();
    // } else if (locationAlwaysStatus.isPermanentlyDenied) {
    //   openAppSettings();
    // }

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }
}
