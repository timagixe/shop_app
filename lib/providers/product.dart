import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite = false;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
  })  : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(imageUrl != null),
        assert(price != null);

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
