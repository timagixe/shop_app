import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartSingleItem extends StatelessWidget {
  final CartItem item;

  CartSingleItem({
    @required this.item,
  }) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text('${item.price}'),
            ),
          ),
        ),
        title: Text('${item.title}'),
        subtitle:
            Text('Total \$${(item.price * item.quantity).toStringAsFixed(2)}'),
        trailing: Text('x ${item.quantity}'),
      ),
    );
  }
}
