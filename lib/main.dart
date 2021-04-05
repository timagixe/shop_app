import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/products.dart';
import './routes/routes.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/products_overview.dart';
import './screens/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(
            [],
            authToken: null,
            userId: null,
          ),
          update: (context, authData, previousProducts) => Products(
            previousProducts.items,
            authToken: authData.token,
            userId: authData.userId,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(
            [],
            authToken: null,
            userId: null,
          ),
          update: (context, authData, previousOrders) => Orders(
            previousOrders.items,
            authToken: authData.token,
            userId: authData.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: getAppRoutes(),
        ),
      ),
    );
  }
}
