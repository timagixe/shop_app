import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';
import '../api/api.dart' show Api;

class Products with ChangeNotifier {
  List<Product> _items;
  final String authToken;
  final String userId;

  Products(
    this._items, {
    @required this.authToken,
    @required this.userId,
  });

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [...items].where((element) => element.isFavorite).toList();

  Future<void> addProduct(Product item) async {
    try {
      final response = await http.post(
          Api.products(
            authToken: authToken,
          ),
          body: item.toJsonWithoutId());
      final productId = json.decode(response.body)['name'];
      _items.add(item.copyWith(
        id: productId,
      ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetProducts({
    bool filterByUser = false,
  }) async {
    try {
      final productsResponse = await http.get(Api.products(
        userId: userId,
        authToken: authToken,
        filterByUser: filterByUser,
      ));
      final productsData =
          json.decode(productsResponse.body) as Map<String, dynamic>;

      final favoriteProductsResponse =
          await http.get(Api.favoriteProductsForUserId(
        userId: userId,
        authToken: authToken,
      ));
      final favoriteProductsData = json.decode(favoriteProductsResponse.body);

      List<Product> fetchedItems = [];
      productsData.forEach((key, value) {
        final bool isFavorite = favoriteProductsData == null
            ? false
            : favoriteProductsData[key] ?? false;

        fetchedItems.add(
          Product.fromJson(key, value).copyWith(
            isFavorite: isFavorite,
          ),
        );
      });
      _items = fetchedItems;
    } catch (error) {
      throw error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product item) async {
    var index = _items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      try {
        await http.patch(
          Api.productsById(
            id: item.id,
            authToken: authToken,
          ),
          body: item.toJsonWithoutId(),
        );
        _items[index] = item;
      } catch (error) {
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

    final response = await http.delete(Api.productsById(
      id: id,
      authToken: authToken,
    ));

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
