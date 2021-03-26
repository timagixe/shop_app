import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../routes/routes.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({
    @required this.product,
  }) : assert(product != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      title: Text(
        product.title,
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.EDIT_PRODUCT,
                  arguments: product,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProductById(product.id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
