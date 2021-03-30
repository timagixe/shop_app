import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  })  : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(imageUrl != null),
        assert(price != null);

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static Product get emptyInstance => Product(
        id: '',
        title: '',
        description: '',
        imageUrl: '',
        price: 0,
      );

  Product copyWith({
    String id,
    String title,
    String description,
    String imageUrl,
    double price,
    bool isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        price: price ?? this.price,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  String toJson() => json.encode(
        {
          'id': id,
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'price': price,
          'isFavorite': isFavorite,
        },
      );

  String toJsonWithoutId() => json.encode(
        {
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'price': price,
          'isFavorite': isFavorite,
        },
      );
}
