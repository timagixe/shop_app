import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';

const double _kChildAspectRatio = 3 / 2;
const int _kCrossAxisCount = 2;
const double _kCrossAxisSpacing = 10.0;
const double _kMainAxisSpacing = 10.0;

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  ProductsGrid({
    @required this.showFavorites,
  }) : assert(showFavorites != null);

  @override
  Widget build(BuildContext context) {
    Products productsProvider = Provider.of<Products>(context);
    List<Product> products =
        showFavorites ? productsProvider.favoriteItems : productsProvider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: _kChildAspectRatio,
        crossAxisCount: _kCrossAxisCount,
        crossAxisSpacing: _kCrossAxisSpacing,
        mainAxisSpacing: _kMainAxisSpacing,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
