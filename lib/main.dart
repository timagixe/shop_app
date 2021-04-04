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
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
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
