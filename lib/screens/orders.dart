import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/order_single_item.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.value().then((value) async {
      _toggleLoading();
      await Provider.of<Orders>(context, listen: false).fetchOrderItems();
      _toggleLoading();
    });
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  OrderSingleItem(orderItem: orders.items[index]),
              itemCount: orders.count,
            ),
    );
  }
}
