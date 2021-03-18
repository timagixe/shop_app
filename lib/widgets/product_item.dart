import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    @required this.product,
  }) : assert(product != null);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
