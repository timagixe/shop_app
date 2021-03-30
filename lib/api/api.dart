class Api {
  static const _baseUrl = 'flutter-shop-614b2-default-rtdb.firebaseio.com';
  static const _products = 'products.json';
  static Uri productsById(String id) {
    return Uri.https(_baseUrl, '/products/$id.json');
  }

  static Uri get products => Uri.https(_baseUrl, _products);
}
