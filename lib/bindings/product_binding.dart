import 'package:belajar_getx/controllers/product_controller.dart';
import 'package:belajar_getx/controllers/cart_controller.dart'; // Import CartController
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    // Gunakan Get.put agar CartController langsung tersedia untuk badge di AppBar
    Get.put(CartController()); 
  }
}