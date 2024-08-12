import 'package:get/get.dart';
import 'package:nemo/app/routes/routes.dart';

class MissingFragmentController extends GetxController {
  Future<void> scanCapture(x) async {
    Get.toNamed(Routes.scanCapture, arguments: [
      {
        'status': x,
        'title': "Missing Fragment\nScan and Camera Capture",
        'halaman': 'scan-camera-capture',
      }
    ]);
  }
}
