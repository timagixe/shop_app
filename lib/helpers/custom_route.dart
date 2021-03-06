import 'package:flutter/material.dart';

import '../routes/routes.dart';

// CAN BE USED FOR SINGLE ROUTE
class CustomRoute<T> extends MaterialPageRoute {
  final WidgetBuilder builder;
  final RouteSettings settings;

  CustomRoute({
    this.builder,
    this.settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == AppRoutes.ROOT) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
