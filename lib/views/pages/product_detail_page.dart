import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../controllers/cart_controller.dart'; 

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final Product product = Get.arguments as Product;

  @override
  Widget build(BuildContext context) {
    final CartController cartC = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        title: const Text("Detail Produk"),
      ),
      
      // Bagian tombol "Add to Cart" 
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            cartC.addToCart(product);
          },
          child: const Text(
            "Tambahkan ke Keranjang",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Center(
                  child: product.images.length > 1
                      ? ListView.separated(
                          itemCount: product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Image.network(product.images[index]),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        )
                      : Image.network(product.images[0]),
                ),
              ),
              const SizedBox(height: 20),
              
              // Judul dan Harga
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Deskripsi
              Text(
                product.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              
              // Tags/Kategori
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: product.tags
                      .map((tag) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              label: Text(tag),
                              backgroundColor: Colors.blueGrey.shade50,
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              
              // Bagian Reviews
              const Text(
                "Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const SizedBox(height: 10),
              Column(
                children: product.reviews.map((review) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade100,
                      child: Text(
                        review['reviewerName'].toString().substring(0, 1),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    trailing: Text(
                      "${review['rating']} ⭐️",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    title: Text(review['reviewerName']),
                    subtitle: Text(review['comment']),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
