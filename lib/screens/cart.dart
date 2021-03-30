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
                  OrderNowButton(orders: orders, cart: cart)
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

class OrderNowButton extends StatefulWidget {
  const OrderNowButton({
    Key key,
    @required this.orders,
    @required this.cart,
  }) : super(key: key);

  final Orders orders;
  final Cart cart;

  @override
  _OrderNowButtonState createState() => _OrderNowButtonState();
}

class _OrderNowButtonState extends State<OrderNowButton> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Widget _buildButtonText(
    bool isButtonDisabled,
  ) {
    return _isLoading
        ? SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          )
        : Text(
            'ORDER NOW',
            style: TextStyle(
              color: isButtonDisabled
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final isButtonDisabled = widget.cart.totalAmount <= 0 || _isLoading;

    return TextButton(
      onPressed: (isButtonDisabled)
          ? null
          : () async {
              _toggleLoading();
              await widget.orders.addOrderItem(
                cartProducts: widget.cart.items.values.toList(),
                amount: widget.cart.totalAmount,
              );
              widget.cart.clear();
              _toggleLoading();
            },
      child: _buildButtonText(
        isButtonDisabled,
      ),
    );
  }
}
