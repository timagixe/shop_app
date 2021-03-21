import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartSingleItem extends StatelessWidget {
  final CartItem item;
  final String productId;

  CartSingleItem({
    @required this.item,
    @required this.productId,
  })  : assert(item != null),
        assert(productId != null);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).errorColor,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItemFromCart(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
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
          subtitle: Text(
              'Total \$${(item.price * item.quantity).toStringAsFixed(2)}'),
          trailing: Text('x ${item.quantity}'),
        ),
      ),
    );
  }
}
