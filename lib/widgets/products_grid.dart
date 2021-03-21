import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

const double _kChildAspectRatio = 3 / 2;
const int _kCrossAxisCount = 2;
const double _kCrossAxisSpacing = 10.0;
const double _kMainAxisSpacing = 10.0;

class ProductsGrid extends StatelessWidget {
  final List<Product> products;

  ProductsGrid({
    @required this.products,
  }) : assert(products != null);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: _kChildAspectRatio,
        crossAxisCount: _kCrossAxisCount,
        crossAxisSpacing: _kCrossAxisSpacing,
        mainAxisSpacing: _kMainAxisSpacing,
      ),
      itemBuilder: (context, index) => ProductItem(
        product: products[index],
      ),
      itemCount: products.length,
    );
  }
}
