import 'package:flutter/material.dart';
import 'package:shop_app/routes/routes.dart';

import '../providers/product.dart';

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
                Navigator.of(context).pushNamed(AppRoutes.EDIT_PRODUCT);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
