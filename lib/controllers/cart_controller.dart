import 'package:get/get.dart';
import '../models/product.dart';

// Class bantuan untuk menyimpan produk dan jumlahnya
class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  // RxList sekarang menyimpan CartItem, bukan langsung Product
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // Method menambah produk / menambah quantity
  void addToCart(Product product) {
    // Cek apakah produk dengan ID yang sama sudah ada di keranjang
    int index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // Jika sudah ada, tambah jumlahnya (quantity)
      cartItems[index].quantity++;
      cartItems.refresh(); // Wajib dipanggil agar Obx di UI menyadari ada perubahan nilai di dalam list
    } else {
      // Jika belum ada, tambahkan sebagai item baru
      cartItems.add(CartItem(product: product));
    }

    Get.snackbar(
      "Berhasil",
      "${product.title} ditambahkan ke keranjang",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Method mengurangi quantity produk (-1)
  void removeOneFromCart(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        // Jika quantity sisa 1 dan dikurangi lagi, hapus item dari keranjang
        cartItems.removeAt(index);
      }
    }
  }

  // Method menghapus produk sepenuhnya dari keranjang (tombol tong sampah)
  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    Get.snackbar(
      "Dihapus",
      "${product.title} dihapus dari keranjang",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Menghitung total harga (Harga Produk * Jumlah)
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  // Menghitung total seluruh item untuk badge di AppBar
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
}