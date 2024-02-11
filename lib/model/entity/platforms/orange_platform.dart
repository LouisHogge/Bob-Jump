import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';

/// The [OrangePlatform] class, extending [MyPlatform], represents an orange
/// platform in the game.
///
/// It features horizontal movement with a configurable speed, allowing it to
/// move left or right.
/// The class includes methods to handle platform movement and
/// direction change: [movePlatform], [changeDirection].

class OrangePlatform extends MyPlatform {
  final double speed;

  bool moveRight = true;

  /// Constructs a new [OrangePlatform] with given spatial properties and speed.
  /// [score] defaults to 20 if not provided.
  OrangePlatform({
    required super.xAxis,
    required super.yAxis,
    required this.speed,
    required super.width,
    required super.height,
    super.score = 20,
  }) : super(type: PlatformType.orange);

  /// Moves the platform horizontally based on its speed and current direction.
  ///
  /// This method updates the platform's horizontal position (xAxis), moving it either
  /// right or left depending on the [moveRight] flag.
  void movePlatform() {
    if (moveRight) {
      xAxis += speed;
    } else {
      xAxis -= speed;
    }
  }

  /// Changes the horizontal movement direction of the platform.
  ///
  /// This method toggles the [moveRight] flag, causing the platform to reverse its
  /// direction of horizontal movement.
  void changeDirection() {
    if (moveRight) {
      moveRight = false;
    } else {
      moveRight = true;
    }
  }

  @override
  Color get color {
    return Colors.orange;
  }
}
