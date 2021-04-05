class Api {
  static const _baseUrl = 'flutter-shop-614b2-default-rtdb.firebaseio.com';
  static const _baseAuthUrl = 'identitytoolkit.googleapis.com';

  static const _products = 'products.json';
  static const _signUp = 'v1/accounts:signUp';
  static const _signInWithPassword = 'v1/accounts:signInWithPassword';
  static const _orders = 'orders.json';

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

  static Uri products(String authToken) {
    return Uri.https(
      _baseUrl,
      _products,
      {
        'auth': authToken,
      },
    );
  }

  static Uri orders(String authToken) {
    return Uri.https(
      _baseUrl,
      _orders,
      {
        'auth': authToken,
      },
    );
  }
}
