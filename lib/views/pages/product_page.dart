import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../views/widgets/product_card.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  // // tidak boleh harusnya
  // final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueGrey),
            );
          }
          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.products[index],
                onTap: () {
                  Get.toNamed("/detail", arguments: controller.products[index]);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
