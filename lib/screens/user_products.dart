import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../routes/routes.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> onRefresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(
      filterByUser: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.EDIT_PRODUCT);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: onRefresh(context),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => onRefresh(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<Products>(
                    builder: (context, productsData, child) => ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            UserProductItem(
                              product: productsData.items[index],
                            ),
                            Divider(),
                          ],
                        );
                      },
                      itemCount: productsData.items.length,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
