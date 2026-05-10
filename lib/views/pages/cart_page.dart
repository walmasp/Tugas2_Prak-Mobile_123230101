import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Keranjang Belanja"),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Keranjang masih kosong"));
        }
        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            // Ambil data CartItem
            final cartItem = controller.cartItems[index];
            final product = cartItem.product;

            return ListTile(
              leading: Image.network(
                product.images[0],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                product.title, 
                maxLines: 1, 
                overflow: TextOverflow.ellipsis
              ),
              subtitle: Text("\$${product.price} x ${cartItem.quantity}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol kurangi quantity
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => controller.removeOneFromCart(product),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 8),
                  // Angka quantity
                  Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  // Tombol tambah quantity
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => controller.addToCart(product),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 8),
                  // Tombol hapus total
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.removeFromCart(product),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
          ],
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Harga:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${controller.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }
}