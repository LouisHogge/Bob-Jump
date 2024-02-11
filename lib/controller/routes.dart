// routes.dart
import 'package:flutter/material.dart';
import 'package:bob_jump/controller/game_controller.dart';
import 'package:bob_jump/controller/game_over_controller.dart';
import 'package:bob_jump/controller/menu_controller.dart';

/// Defines the navigation routes for the application.
///
/// [routes] associates route names with corresponding widget builders.
final Map<String, WidgetBuilder> routes = {
  '/homeMenu': (context) => const Scaffold(body: MainMenu()),
  '/game': (context) => Scaffold(body: GameScreen(context)),
  '/gameOver': (context) => const Scaffold(body: GameOverScreen()),
};
