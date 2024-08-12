import 'package:get/get.dart';
import '../controllers/scan_capture_controller.dart';

class ScanCaptureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanCaptureController>(() => ScanCaptureController());
  }
}
