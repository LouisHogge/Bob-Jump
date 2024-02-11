import 'dart:math';

import 'package:bob_jump/model/manager/bubble_manager.dart';
import 'package:bob_jump/model/manager/monster_manager.dart';
import 'package:bob_jump/model/manager/platform_manager.dart';
import 'package:bob_jump/model/manager/power_up_manager.dart';
import 'package:bob_jump/model/physics_engine.dart';

/// Manages the generation of game levels with varying difficulty and complexity.
///
/// The [GameGeneration] class is responsible for generating different scenarios for game levels,
/// adjusting elements based on the current level and randomly picking difficulty.
class GameGeneration {
  double platformWidthFactor = 0;
  double platformHeightFactor = 0;
  int batchNumber = 0;
  int level;
  static const int maxLevel = 15;
  final double screenHeight;
  final double screenWidth;

  /// Dict containing all scenarios
  static const Map<String, Map<String, List<Map<String, dynamic>>>> _scenarios =
      {
    'easy': {
      // compacted green
      'easy1': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.2},
      ],
      // compacted green
      'easy2': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.2},
      ],
      // compacted green
      'easy3': [
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.2},
      ],
      // compacted green then easy green
      'easy4': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
      ],
      // easy green
      'easy5': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.8},
      ],
      // green + white
      'easy6': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
      ],
      // green + orange
      'easy7': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.2},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
      ],
      // green + pink
      'easy8': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
      ],
      // green + brown
      'easy9': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.3, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.7, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.3, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.5},
        {'type': 'brown', 'xOffset': 0.5, 'yOffset': 0.2},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
      ],
      // green + springShoes
      'easy10': [
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'springShoes', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
      ],
      // green + trampoline
      'easy11': [
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'trampoline', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
      ],
      // green + flyer
      'easy12': [
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'flyer', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.4},
      ]
    },
    'medium': {
      // green + brown + orange + springShoes
      'medium1': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.6},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'brown', 'xOffset': 0.3, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'brown', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'springShoes', 'xOffset': 0.7, 'yOffset': 0.1},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.8},
      ],
      // green + brown + white + trampoline
      'medium2': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'brown', 'xOffset': 0.3, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'brown', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'trampoline', 'xOffset': 0.7, 'yOffset': 0.1},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.8},
      ],
      // green + brown + pink + flyer
      'medium3': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'brown', 'xOffset': 0.3, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'brown', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'flyer', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.8},
      ],
      // orange
      'medium4': [
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
      ],
      // white zigzag
      'medium5': [
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
      ],
      // pink
      'medium6': [
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 1.0},
      ],
      // compacted white then white
      'medium7': [
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.4},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.4},
        {'type': 'white', 'xOffset': 0.8, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.3},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.4},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.8, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.8},
      ],
      // easy white + monster
      'medium8': [
        {'type': 'white', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.1, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'flyer', 'xOffset': 0.5, 'yOffset': 0.1},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.8},
      ],
      // compacted orange then orange
      'medium9': [
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.4},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.4},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.3},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.3},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.4},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.8},
      ],
      // easy orange + monster
      'medium10': [
        {'type': 'orange', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.1, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.8},
      ],
      // multiple platforms, shield and monster
      'medium11': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.4},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.4},
        {'type': 'shield', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'pink', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.3},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.6},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'monster', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.4, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.7},
      ],
      // multiple platforms, trampolines and monster
      'medium12': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.6},
        {'type': 'trampoline', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 0.7},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 0.7},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'monster', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 0.7},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 0.6},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.6},
        {'type': 'trampoline', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.8},
      ]
    },
    'hard': {
      // green staircase + monsters
      'hard1': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.9, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.1, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.9, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.1, 'yOffset': 0.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 1.0},
      ],
      // multiple platforms, shield and monster
      'hard2': [
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.9},
        {'type': 'shield', 'xOffset': 0.0, 'yOffset': 0.1},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.8},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.9, 'yOffset': 0.9},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.4, 'yOffset': 0.8},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'monster', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.9},
      ],
      // multiple platforms, shield and monster
      'hard3': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 0.9},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'shield', 'xOffset': 0.1, 'yOffset': 0.1},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 1.0},
      ],
      // all platforms + flyer
      'hard4': [
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.8, 'yOffset': 0.9},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.8, 'yOffset': 0.9},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.8, 'yOffset': 0.9},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'pink', 'xOffset': 0.8, 'yOffset': 0.9},
        {'type': 'white', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'flyer', 'xOffset': 0.2, 'yOffset': 0.1},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
      ],
      // all platforms + trampoline
      'hard5': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'brown', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.9, 'yOffset': 0.5},
        {'type': 'trampoline', 'xOffset': 0.9, 'yOffset': 0.1},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.4, 'yOffset': 0.9},
        {'type': 'brown', 'xOffset': 0.9, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.8, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 0.9},
        {'type': 'brown', 'xOffset': 0.1, 'yOffset': 0.5},
        {'type': 'green', 'xOffset': 0.9, 'yOffset': 0.5},
        {'type': 'trampoline', 'xOffset': 0.9, 'yOffset': 0.1},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.4, 'yOffset': 0.9},
        {'type': 'green', 'xOffset': 0.9, 'yOffset': 1.0},
      ],
      // monster tunnel
      'hard6': [
        {'type': 'green', 'xOffset': 0.4, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.2, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.3, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 0.8},
        {'type': 'monster', 'xOffset': 0.7, 'yOffset': 0.2},
        {'type': 'green', 'xOffset': 0.0, 'yOffset': 0.8},
      ],
      // platforms blocks
      'hard7': [
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'shield', 'xOffset': 0.7, 'yOffset': 0.1},
        {'type': 'pink', 'xOffset': 0.9, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 0.8},
        {'type': 'white', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.9, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 1.0},
      ],
      // platforms blocks
      'hard8': [
        {'type': 'orange', 'xOffset': 0.9, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'white', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.9, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.5, 'yOffset': 0.8},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 0.8},
        {'type': 'green', 'xOffset': 0.1, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.5, 'yOffset': 1.0},
        {'type': 'green', 'xOffset': 0.7, 'yOffset': 1.0},
        {'type': 'flyer', 'xOffset': 0.7, 'yOffset': 0.1},
      ],
      // pink + monsters
      'hard9': [
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.4, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.3, 'yOffset': 1.0},
        {'type': 'pink', 'xOffset': 0.7, 'yOffset': 0.0},
        {'type': 'pink', 'xOffset': 0.6, 'yOffset': 1.0},
      ],
      // orange + monsters
      'hard10': [
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.2, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.4, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 0.6, 'yOffset': 0.5},
        {'type': 'orange', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.5, 'yOffset': 0.5},
      ],
      // white zigzag + monsters + flyer
      'hard11': [
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'white', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'flyer', 'xOffset': 1.0, 'yOffset': 0.1},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 0.0},
      ],
      // brown zigzag + monsters
      'hard12': [
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 0.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 1.0, 'yOffset': 0.0},
        {'type': 'monster', 'xOffset': 1.0, 'yOffset': 1.0},
        {'type': 'brown', 'xOffset': 0.0, 'yOffset': 0.0},
      ]
    },
  };

  GameGeneration(
      {required this.screenHeight,
      required this.screenWidth,
      required this.level});

  get getLevel => level;

  /// Generates a linear interpolation between a minimum and maximum value based on the current level.
  ///
  /// Useful for scaling game difficulty and parameters as the player progresses through levels.
  double getLinearInterpolation(double minValue, double maxValue) {
    switch (level) {
      case 1:
        return minValue;
      case maxLevel:
        return maxValue;
      default:
        return minValue +
            ((maxValue - minValue) / (maxLevel - 1)) * (level - 1);
    }
  }

  /// Chooses a scenario based on the current level and randomness to add variety to the game.
  ///
  /// Decides which type of platforms, power-ups, and monsters to generate based on level difficulty.
  void pickScenario(
    PlatformManager platformManager,
    PowerUpManager powerUpManager,
    MonsterManager monsterManager,
  ) {
    Random random = Random();
    int chance = random.nextInt(100);
    String difficulty;
    if (level <= 5) {
      if (chance < 85) {
        difficulty = 'easy';
      } else if (chance < 95) {
        difficulty = 'medium';
      } else {
        difficulty = 'hard';
      }
    } else if (level <= 10) {
      if (chance < 85) {
        difficulty = 'medium';
      } else if (chance < 95) {
        difficulty = 'easy';
      } else {
        difficulty = 'hard';
      }
    } else {
      if (chance < 85) {
        difficulty = 'hard';
      } else if (chance < 95) {
        difficulty = 'medium';
      } else {
        difficulty = 'easy';
      }
    }

    var difficultyScenarios = _scenarios[difficulty];
    if (difficultyScenarios != null && difficultyScenarios.isNotEmpty) {
      var scenarioKeys = difficultyScenarios.keys.toList();
      var randomScenarioKey =
          scenarioKeys[Random().nextInt(scenarioKeys.length)];

      var chosenScenario = difficultyScenarios[randomScenarioKey];

      if (chosenScenario != null) {
        buildScenario(
            platformManager,
            powerUpManager,
            monsterManager,
            getLinearInterpolation(0.0, 0.75),
            getLinearInterpolation(0.25, 1.0),
            chosenScenario);
      }
    }
  }

  /// Constructs a specific game scenario from a set of components.
  ///
  /// Builds platforms, power-ups, and monsters based on a predefined scenario structure.
  void buildScenario(
      PlatformManager platformManager,
      PowerUpManager powerUpManager,
      MonsterManager monsterManager,
      double minSpeed,
      double maxSpeed,
      List<Map<String, dynamic>> components) {
    platformWidthFactor = platformManager.getPlatformWidthFactor;
    platformHeightFactor = platformManager.getPlatformHeightFactor;

    double minY = 0.0;
    double maxY = 0.25 - platformHeightFactor;

    double minX = platformWidthFactor / 2;
    double maxX = 1.0 - (platformWidthFactor / 2);

    double y = platformManager.getComponent.last.getYAxis;

    for (var component in components) {
      // yOffset is an y offset from the last platform
      double deltaY =
          (component['yOffset'] * (maxY - minY) + minY) * screenHeight;
      y += deltaY;

      // xOffset is an x offset from the left side of the screen
      double x = (component['xOffset'] * (maxX - minX) + minX) * screenWidth;

      switch (component['type']) {
        case 'green':
          platformManager.addGreenPlatform(x, y);
          break;
        case 'white':
          platformManager.addWhitePlatform(x, y);
          break;
        case 'orange':
          platformManager.addOrangePlatform(x, y, minSpeed, maxSpeed);
          break;
        case 'pink':
          platformManager.addPinkPlatform(x, y, minSpeed, maxSpeed, 30.0);
          break;
        case 'brown':
          platformManager.addBrownPlatform(x, y);
          break;
        case 'trampoline':
          powerUpManager.addPowerUpTrampoline(x, y);
          break;
        case 'flyer':
          powerUpManager.addPowerUpFlyer(x, y);
          break;
        case 'springShoes':
          powerUpManager.addPowerUpShoes(x, y);
          break;
        case 'shield':
          powerUpManager.addShield(x, y);
          break;
        case 'monster':
          monsterManager.addMonster(x, y);
          break;
      }
    }
  }

  /// Generates the game level, determining the composition and challenge of the current stage.
  ///
  /// Handles the addition of game components to the level, scaling difficulty and variety.
  void generateLevel(
    PlatformManager platformManager,
    PowerUpManager powerUpManager,
    MonsterManager monsterManager,
    PhysicsEngine physicsEngine,
    BubbleManager bubbleManager,
  ) {
    if (platformManager.getComponent.length < 20) {
      pickScenario(platformManager, powerUpManager, monsterManager);
      physicsEngine.changeTimeIncrement(getLinearInterpolation(0.1, 0.2));

      batchNumber++;
      if (batchNumber >= 5 && level < maxLevel) {
        batchNumber == 0;
        level += 1;
        if (level == 6) {
          bubbleManager.increase();
        } else if (level == 11) {
          bubbleManager.increase();
        }
      }
    }
  }
}
