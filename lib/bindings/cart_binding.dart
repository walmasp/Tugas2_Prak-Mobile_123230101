import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // Controller sudah di-put di awal, tapi ini memenuhi syarat struktur Binding
    Get.lazyPut(() => CartController());
  }
}