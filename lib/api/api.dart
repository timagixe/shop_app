class Api {
  static const _baseUrl = 'flutter-shop-614b2-default-rtdb.firebaseio.com';

  static const _products = 'products.json';
  static Uri productsById(String id) {
    return Uri.https(_baseUrl, '/products/$id.json');
  }

  static const _orders = 'orders.json';

  static Uri get products => Uri.https(_baseUrl, _products);
  static Uri get orders => Uri.https(_baseUrl, _orders);
}
