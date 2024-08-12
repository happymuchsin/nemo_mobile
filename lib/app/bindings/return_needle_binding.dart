import 'package:get/get.dart';
import '../controllers/return_needle_controller.dart';

class ReturnNeedleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnNeedleController>(() => ReturnNeedleController());
  }
}
