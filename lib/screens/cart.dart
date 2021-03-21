import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_single_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    Orders orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FlatButton(
                    onPressed: () {
                      orders.addOrderItem(
                        cartProducts: cart.items.values.toList(),
                        amount: cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartSingleItem(
                item: cart.items.values.toList()[index],
                productId: cart.items.keys.toList()[index],
              ),
              itemCount: cart.itemsCount,
            ),
          )
        ],
      ),
    );
  }
}
