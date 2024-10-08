import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/models/portal_model.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:version/version.dart';

class PortalController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();
  var mode = "".obs, username = "".obs, deviceType = "".obs, version = "".obs;
  var bChangeNeedle = false.obs, bApproval = false.obs, bRequestNewNeedle = false.obs, bNeedleStock = false.obs;

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
  void onReady() async {
    super.onReady();

    deviceType(getDevice());
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version now = Version.parse(packageInfo.version);
    version(now.toString());
    awalan();
  }

  void awalan() async {
    var a = await initialize();
    if (a == 'yes') {
      await checkPermission();

      bRequestNewNeedle(true);
      bChangeNeedle(true);
      bApproval(true);
      bNeedleStock(true);

      dataModel.add(PortalModel(
          route: Routes.requestNewNeedle,
          name: 'Request New Needle',
          tipe: 'image',
          source: 'assets/img/requestNewNeedle.png',
          visible: bRequestNewNeedle.value,
          args: {
            'step': '1',
          }));
      dataModel.add(PortalModel(
          route: Routes.changeNeedle,
          name: 'Change Needle',
          tipe: 'image',
          source: 'assets/img/changeNeedle.png',
          visible: bChangeNeedle.value,
          args: {
            'step': '1',
          }));
      dataModel
          .add(PortalModel(route: Routes.approval, name: 'Approval', tipe: 'image', source: 'assets/img/approval.png', visible: bApproval.value));
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
