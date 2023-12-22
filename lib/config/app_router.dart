import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tuncjob/models/models.dart';
import 'package:tuncjob/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    log('The Route is: ${settings.name}');

    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case UsersScreen.routeName:
        var user = settings.arguments as User;
        return UsersScreen.route(user: user);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case ChatScreen.routeName:
        var userMatch = settings.arguments as UserMatch;
        return ChatScreen.route(userMatch: userMatch);
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
