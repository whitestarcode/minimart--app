import 'package:flutter/material.dart';
import 'package:minimart_app/models/product.dart';


class FavoriteProvider with ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  void toggleFavorite(Product product) {
    final isAlreadyFavorite = _favoriteItems.any(
      (item) => item.id == product.id,
    );
    if (isAlreadyFavorite) {
      _favoriteItems.removeWhere((item) => item.id == product.id);
      product.isFavorite = false;
    } else {
      _favoriteItems.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteItems.any((item) => item.id == product.id);
  }
}
