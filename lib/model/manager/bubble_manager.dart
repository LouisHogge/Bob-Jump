import 'dart:math';

import 'package:bob_jump/model/entity/bubble.dart';

/// The [BubbleManager] class manages bubbles in the game environment.
///
/// It handles the creation, tracking, and updating of bubbles of different types
/// based on the game's level and screen dimensions. The class is responsible for
/// [initializeBubble], [increase], and managing the lifecycle of bubbles on the screen.

class BubbleManager {
  final List<Bubble> bubbles = [];

  static const double bubbleWidthFactor = 0.3;
  static const double bubbleHeightFactor = 0.15;

  final double screenWidth;
  final double screenHeight;

  BubbleManager({required this.screenWidth, required this.screenHeight});

  List<Bubble> get getBubbles => bubbles;

  /// Updates the state of bubbles each tick.
  ///
  /// This method is called regularly (each tick) to perform checks on the bubbles,
  /// such as their position and need for replacement or state change.
  void tick() {
    _checkBubble();
  }

  /// Increases the state of each bubble.
  ///
  /// Iterates through all bubbles, invoking their `increase` method to potentially
  /// change their type or state based on defined rules.
  void increase() {
    for (Bubble bubble in bubbles) {
      bubble.increase();
    }
  }

  void initializeBubble(int level) {
    switch (level) {
      case 1:
        _initializeBlue();
        break;
      case 6:
        _initializeOrange();
        break;
      case 11:
        _initializeRed();
        break;
      default:
    }
  }

  void _initializeRed() {
    double x;
    for (int i = 0; i < 13; i++) {
      x = Random().nextDouble();
      bubbles.add(Bubble(
          xAxis: x * screenWidth,
          yAxis: i * (screenHeight / 10),
          type: BubbleType.red,
          width: bubbleWidthFactor * screenWidth,
          height: bubbleHeightFactor * screenHeight));
    }
  }

  void _initializeOrange() {
    double x;
    for (int i = 0; i < 13; i++) {
      x = Random().nextDouble();
      bubbles.add(Bubble(
          xAxis: x * screenWidth,
          yAxis: i * (screenHeight / 10),
          type: BubbleType.orange,
          width: bubbleWidthFactor * screenWidth,
          height: bubbleHeightFactor * screenHeight));
    }
  }

  void _initializeBlue() {
    double x;
    for (int i = 0; i < 13; i++) {
      x = Random().nextDouble();
      bubbles.add(Bubble(
          xAxis: x * screenWidth,
          yAxis: i * (screenHeight / 10),
          type: BubbleType.blue,
          width: bubbleWidthFactor * screenWidth,
          height: bubbleHeightFactor * screenHeight));
    }
  }

  /// Checks the position of each bubble and replaces it if needed.
  ///
  /// Iterates through the bubbles, replacing those that have moved off-screen
  /// to maintain a consistent number of bubbles in the game.
  void _checkBubble() {
    for (Bubble bubble in bubbles) {
      if (bubble.getYAxis < -0.2 * screenHeight) {
        _replaceBubble(bubble);
      }
    }
  }

  /// Replaces a bubble that has moved off-screen.
  ///
  /// Adjusts the position of the given [bubble], repositioning it back into the
  /// game's visible area.
  void _replaceBubble(Bubble bubble) {
    double x = Random().nextDouble();
    bubble.move(x, 13 / 10 * screenHeight);
  }
}
