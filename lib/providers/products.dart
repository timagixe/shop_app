import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../mocks/products.dart';
import 'product.dart';
import '../api/api.dart' show Api;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [...items].where((element) => element.isFavorite).toList();

  Future<void> addProduct(Product item) async {
    try {
      final response =
          await http.post(Api.products, body: item.toJsonWithoutId());
      final productId = json.decode(response.body)['name'];
      _items.add(item.copyWith(
        id: productId,
      ));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(Api.products);
      var decodedBody = json.decode(response.body) as Map<String, dynamic>;
      List<Product> fetchedItems = [];
      decodedBody.forEach((key, value) {
        fetchedItems.add(Product.fromJson(key, value));
      });
      _items = fetchedItems;
    } catch (error) {
      print(error);
      throw error;
    } finally {
      notifyListeners();
    }
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
