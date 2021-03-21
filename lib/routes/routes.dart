import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart.dart';

import '../screens/product_detail.dart';
import '../screens/products_overview.dart';

class AppRoutes {
  static const String ROOT = '/';
  static const String PRODUCTS_OVERVIEW = '/products-overview';
  static const String PRODUCT_DETAILS = '/product-details';
  static const String CART = '/cart';
}

const String kAppInitialRoute = AppRoutes.ROOT;

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    AppRoutes.ROOT: (context) => ProductsOverviewScreen(),
    AppRoutes.PRODUCT_DETAILS: (context) => ProductDetailScreen(),
    AppRoutes.CART: (context) => CartScreen(),
  };
}
