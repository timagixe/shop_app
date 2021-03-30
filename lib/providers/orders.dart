import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../providers/cart.dart';
import '../api/api.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  })  : assert(id != null),
        assert(amount != null),
        assert(dateTime != null),
        assert(products != null);

  String toJson() => json.encode(
        {
          'id': id,
          'amount': amount,
          'dateTime': dateTime.toIso8601String(),
          'products': products
              .map(
                (e) => json.decode(e.toJson()),
              )
              .toList(),
        },
      );

  String toJsonWithoutId() => json.encode(
        {
          'amount': amount,
          'dateTime': dateTime.toIso8601String(),
          'products': products
              .map(
                (e) => json.decode(e.toJson()),
              )
              .toList(),
        },
      );
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  int get count => _items.length;

  Future<void> addOrderItem({
    @required List<CartItem> cartProducts,
    @required double amount,
  }) async {
    final createdAt = DateTime.now();
    final response = await http.post(
      Api.orders,
      body: OrderItem(
        id: Uuid().v4(),
        amount: amount,
        dateTime: createdAt,
        products: cartProducts,
      ).toJsonWithoutId(),
    );

    final orderItemId = json.decode(response.body)['name'];

    _items.insert(
        0,
        OrderItem(
          id: orderItemId,
          amount: amount,
          dateTime: createdAt,
          products: cartProducts,
        ));
    notifyListeners();
  }
}
