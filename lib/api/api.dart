class Api {
  String _baseUrl = 'flutter-shop-614b2-default-rtdb.firebaseio.com';
  String _products = 'products.json';

  Uri get products => Uri.https(_baseUrl, _products);
}
