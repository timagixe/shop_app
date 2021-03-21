import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../routes/routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum PopupMenuOptions {
  Favorite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
        actions: [
          PopupMenuButton(
            onSelected: (PopupMenuOptions option) {
              if (option == PopupMenuOptions.Favorite) {
                setState(() {
                  _showFavorites = true;
                });
              } else {
                setState(() {
                  _showFavorites = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite Items'),
                value: PopupMenuOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('All Items'),
                value: PopupMenuOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: child,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(
        showFavorites: _showFavorites,
      ),
    );
  }
}
