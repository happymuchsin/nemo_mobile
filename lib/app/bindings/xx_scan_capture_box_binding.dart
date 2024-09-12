import 'package:get/get.dart';
import '../controllers/xx_scan_capture_box_controller.dart';

class ScanCaptureBoxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanCaptureBoxController>(() => ScanCaptureBoxController());
  }
}
