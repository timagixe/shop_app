import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../providers/cart.dart';

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
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  int get count => _items.length;

  void addOrderItem({
    @required List<CartItem> cartProducts,
    @required double amount,
  }) {
    _items.insert(
        0,
        OrderItem(
          id: Uuid().v4(),
          amount: amount,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
    notifyListeners();
  }
}
