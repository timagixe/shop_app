import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    @required this.product,
  }) : assert(product != null);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black38,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
