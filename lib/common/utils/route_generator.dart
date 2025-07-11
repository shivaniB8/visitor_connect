import 'package:flutter/material.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return createFadeTransitionRoute(
          const HomePage(),
          routeSettings,
        );

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> createSimpleRoute(
    Widget screenWidget,
    RouteSettings? routeSettings,
  ) {
    return MaterialPageRoute(
      builder: (_) => screenWidget,
      settings: routeSettings,
    );
  }

  static Route createFadeTransitionRoute(
    Widget screenWidget, [
    RouteSettings? routeSettings,
  ]) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screenWidget,
      transitionsBuilder: (_, anim, __, child) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 500),
      settings: routeSettings,
    );
  }

  // Creates routes for invalid route names
  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            'Wrong route',
          ),
        ),
      ),
    );
  }
}

Route<dynamic> goToRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route<dynamic> noSlideRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
