import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exceotion.dart';
import './product.dart';
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

  Future<void> updateProduct(Product item) async {
    var index = _items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      try {
        print(Api.productsById(item.id));
        await http.patch(
          Api.productsById(item.id),
          body: item.toJsonWithoutId(),
        );
        _items[index] = item;
      } catch (error) {
        print(error);
        throw error;
      } finally {
        notifyListeners();
      }
    } else {
      print('updateProduct: product with ${item.id} does not exist');
    }
  }

  Future<void> deleteProductById(String id) async {
    final existingProductIndex = _items.indexWhere(
      (element) => element.id == id,
    );
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(Api.productsById(id));

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException(message: 'Could not delete the product');
    }
    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
