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
  Future _ordersFuture;

  Future _obtainOrdersFuture() =>
      Provider.of<Orders>(context, listen: false).fetchOrderItems();

  @override
  void initState() {
    super.initState();
    _ordersFuture = _obtainOrdersFuture();
  }

  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, dataSnapshot) {
          print(dataSnapshot.connectionState);
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Error occurred when loading data'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    OrderSingleItem(orderItem: orders.items[index]),
                itemCount: orders.count,
              );
            }
          }
        },
      ),
    );
  }
}
