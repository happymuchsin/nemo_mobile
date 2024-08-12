import 'package:get/get.dart';
import '../controllers/request_new_needle_controller.dart';

class RequestNewNeedleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestNewNeedleController>(() => RequestNewNeedleController());
  }
}
