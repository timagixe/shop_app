import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderSingleItem extends StatefulWidget {
  final OrderItem orderItem;

  const OrderSingleItem({
    @required this.orderItem,
  }) : assert(orderItem != null);

  @override
  _OrderSingleItemState createState() => _OrderSingleItemState();
}

class _OrderSingleItemState extends State<OrderSingleItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _expanded
          ? min(widget.orderItem.products.length.toDouble() * 25 + 110, 200)
          : 100,
      curve: Curves.linear,
      duration: Duration(milliseconds: 300),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.orderItem.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd.MM.yyyy hh:mm')
                    .format(widget.orderItem.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              curve: Curves.linear,
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 15,
              ),
              height: _expanded
                  ? min(
                      widget.orderItem.products.length.toDouble() * 25 + 8, 125)
                  : 0,
              child: ListView.builder(
                  itemBuilder: (context, index) => Container(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.orderItem.products[index].title}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${widget.orderItem.products[index].quantity} x \$${widget.orderItem.products[index].price}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                  itemCount: widget.orderItem.products.length),
            )
          ],
        ),
      ),
    );
  }
}
