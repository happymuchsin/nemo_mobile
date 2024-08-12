import 'package:get/get.dart';
import '../controllers/portal_controller.dart';

class PortalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PortalController>(PortalController());
  }
}
