import 'package:get/get.dart';
import '../controllers/xx_replacement_needle_controller.dart';

class ReplacementNeedleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplacementNeedleController>(() => ReplacementNeedleController());
  }
}
