import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final Product product = Provider.of<Products>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text('Product Details'),
      ),
    );
  }
}
