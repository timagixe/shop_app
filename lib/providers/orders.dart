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

  OrderItem.fromJson(String id, Map<String, dynamic> json)
      : id = id,
        amount = json['amount'],
        dateTime = DateTime.parse(json['dateTime']),
        products = (json['products'] as List)
            .map((itemJson) => CartItem.fromJson(itemJson))
            .toList();
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];
  final String authToken;

  Orders(
    this._items, {
    @required this.authToken,
  });

  List<OrderItem> get items => [..._items];

  int get count => _items.length;

  Future<void> fetchOrderItems() async {
    final response = await http.get(Api.orders(authToken));
    final decodedOrderItems =
        json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> fetchedOrderItems = [];
    decodedOrderItems.forEach(
      (key, value) {
        fetchedOrderItems.add(OrderItem.fromJson(key, value));
      },
    );
    _items = fetchedOrderItems.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrderItem({
    @required List<CartItem> cartProducts,
    @required double amount,
  }) async {
    final createdAt = DateTime.now();
    final response = await http.post(
      Api.orders(authToken),
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
