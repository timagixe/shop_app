import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product.dart';

import '../screens/cart.dart';
import '../screens/orders.dart';
import '../screens/user_products.dart';

import '../screens/product_detail.dart';
import '../screens/products_overview.dart';

class AppRoutes {
  static const String ROOT = '/';
  static const String PRODUCTS_OVERVIEW = '/products-overview';
  static const String PRODUCT_DETAILS = '/product-details';
  static const String CART = '/cart';
  static const String ORDERS = '/orders';
  static const String USER_PRODUCTS = '/user-products';
  static const String EDIT_PRODUCT = '/edit-product';
}

const String kAppInitialRoute = AppRoutes.ROOT;

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    AppRoutes.ROOT: (context) => ProductsOverviewScreen(),
    AppRoutes.PRODUCT_DETAILS: (context) => ProductDetailScreen(),
    AppRoutes.CART: (context) => CartScreen(),
    AppRoutes.ORDERS: (context) => OrdersScreen(),
    AppRoutes.USER_PRODUCTS: (context) => UserProductsScreen(),
    AppRoutes.EDIT_PRODUCT: (context) => EditProductScreen(),
  };
}
