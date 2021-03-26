import 'package:flutter/material.dart';

import '../mocks/products.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [...mockedProducts];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [...items].where((element) => element.isFavorite).toList();

  void addProduct(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void updateProduct(Product item) {
    var index = _items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      _items[index] = item;
      notifyListeners();
    } else {
      print('updateProduct: product with ${item.id} does not exist');
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
