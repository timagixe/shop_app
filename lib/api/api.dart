import 'package:flutter/foundation.dart';

class Api {
  static const _baseUrl = 'flutter-shop-614b2-default-rtdb.firebaseio.com';
  static const _baseAuthUrl = 'identitytoolkit.googleapis.com';

  static const _products = 'products.json';
  static const _signUp = 'v1/accounts:signUp';
  static const _signInWithPassword = 'v1/accounts:signInWithPassword';
  static _ordersByUserId(String id) {
    return 'orders/$id.json';
  }

  static Uri favoriteProductForUserIdByProductId({
    String userId,
    String authToken,
    String productId,
  }) {
    return Uri.https(
      _baseUrl,
      '/favoriteProducts/$userId/$productId.json',
      {
        'auth': authToken,
      },
    );
  }

  static Uri favoriteProductsForUserId({
    String userId,
    String authToken,
  }) {
    return Uri.https(
      _baseUrl,
      '/favoriteProducts/$userId.json',
      {
        'auth': authToken,
      },
    );
  }

  static Uri productsById({
    String id,
    String authToken,
  }) {
    return Uri.https(
      _baseUrl,
      '/products/$id.json',
      {
        'auth': authToken,
      },
    );
  }

  static Uri signUp(String apiKey) {
    return Uri.https(
      _baseAuthUrl,
      _signUp,
      {
        'key': apiKey,
      },
    );
  }

  static Uri logIn(String apiKey) {
    return Uri.https(
      _baseAuthUrl,
      _signInWithPassword,
      {
        'key': apiKey,
      },
    );
  }

  static Uri products({
    @required String authToken,
    bool filterByUser = false,
    String userId = '',
  }) {
    return filterByUser
        ? Uri.https(
            _baseUrl,
            _products,
            {
              'auth': authToken,
              'orderBy': '\"creatorId\"',
              'equalTo': '\"$userId\"',
            },
          )
        : Uri.https(
            _baseUrl,
            _products,
            {
              'auth': authToken,
            },
          );
  }

  static Uri orders({
    String authToken,
    String userId,
  }) {
    return Uri.https(
      _baseUrl,
      _ordersByUserId(userId),
      {
        'auth': authToken,
      },
    );
  }
}
