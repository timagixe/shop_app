import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/order_single_item.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            OrderSingleItem(orderItem: orders.items[index]),
        itemCount: orders.count,
      ),
    );
  }
}
