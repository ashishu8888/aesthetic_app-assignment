import 'package:aesthetic_app/authentication/auth_screen.dart';
import 'package:aesthetic_app/authentication/otp_screen.dart';
import 'package:aesthetic_app/screens/add_movie_form.dart';
import 'package:flutter/material.dart';

import 'screens/error_screen.dart';
import 'screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      );
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
      );
    case AddMovieScreen.routeNmae:
      return MaterialPageRoute(
        builder: (ctx) => const AddMovieScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (ctx) => const Scaffold(
          body: ErrorScreen(
            error: 'This page doesn\'t exist',
          ),
        ),
      );
  }
}
