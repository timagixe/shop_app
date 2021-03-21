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
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: Dismissible(
        key: ValueKey(item.id),
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).errorColor,
          ),
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false)
              .removeItemFromCart(productId);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(0),
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
      ),
    );
  }
}
