import 'package:get/get.dart';
import '../controllers/missing_fragment_controller.dart';

class MissingFragmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MissingFragmentController>(() => MissingFragmentController());
  }
}
