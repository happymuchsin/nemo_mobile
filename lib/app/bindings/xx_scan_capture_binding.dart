import 'package:get/get.dart';
import '../controllers/xx_scan_capture_controller.dart';

class ScanCaptureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanCaptureController>(() => ScanCaptureController());
  }
}
