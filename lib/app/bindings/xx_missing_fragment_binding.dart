import 'package:get/get.dart';
import '../controllers/xx_missing_fragment_controller.dart';

class MissingFragmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MissingFragmentController>(() => MissingFragmentController());
  }
}
