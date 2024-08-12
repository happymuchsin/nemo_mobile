import 'package:get/get.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';

class MissingFragmentController extends GetxController {
  var deviceType = "".obs;

  Future<void> scanCapture(x) async {
    Get.toNamed(Routes.scanCapture, arguments: [
      {
        'status': x,
        'title': "Missing Fragment\nScan and Camera Capture",
        'halaman': 'scan-camera-capture',
      }
    ]);
  }

  @override
  void onInit() {
    super.onInit();

    deviceType(getDevice());
  }
}
