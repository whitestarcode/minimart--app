import 'package:flutter/material.dart';
import 'package:minimart_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartItem = [];

  List<Product> get cartItems => cartItem;

  int get cartCount => cartItem.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(Product product) {
    var existingProduct = cartItem.firstWhere(
      (item) => item.id == product.id,
      orElse: () => product,
    );
    if (cartItem.contains(existingProduct)) {
      existingProduct.quantity++;
    } else {
      product.quantity = 1;
      cartItem.add(product);
    }
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      cartItem.remove(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cartItem.remove(product);
    notifyListeners();
  }
}
