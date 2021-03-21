import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';
import '../providers/products.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
      ),
      body: ProductsGrid(products: products),
    );
  }
}
