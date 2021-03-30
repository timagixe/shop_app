import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../mocks/products.dart';
import 'product.dart';
import '../api/api.dart' show Api;

class Products with ChangeNotifier {
  List<Product> _items = [...mockedProducts];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [...items].where((element) => element.isFavorite).toList();

  void addProduct(Product item) {
    http.post(Api().products, body: item.toJsonWithoutId()).then((response) {
      final productId = json.decode(response.body)['name'];
      _items.add(item.copyWith(
        id: productId,
      ));
      notifyListeners();
    });
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

  void deleteProductById(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
