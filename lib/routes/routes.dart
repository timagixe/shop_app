import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/products_overview.dart';

class AppRoutes {
  static const String ROOT = '/';
  static const String PRODUCTS_OVERVIEW = '/products-overview';
  static const String PRODUCT_DETAILS = '/product-details';
}

const String kAppInitialRoute = AppRoutes.ROOT;

Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.ROOT: (context) => ProductsOverviewScreen(),
  AppRoutes.PRODUCT_DETAILS: (context) => ProductDetailScreen(),
};
