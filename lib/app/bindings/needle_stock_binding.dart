import 'package:get/get.dart';
import '../controllers/needle_stock_controller.dart';

class NeedleStockBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NeedleStockController>(() => NeedleStockController());
  }
}
