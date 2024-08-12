import 'package:get/get.dart';
import '../controllers/change_needle_controller.dart';

class ChangeNeedleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeNeedleController>(() => ChangeNeedleController());
  }
}
