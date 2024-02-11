import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';

/// The [PinkPlatform] class, extending [MyPlatform], represents a pink platform in the game.
///
/// This platform has the ability to move vertically within a defined travel radius.
/// It is characterized by its speed of movement, the total distance it can travel (travelRadius),
/// and a default score value. The platform's movement direction changes upon reaching the travel
/// radius limits.
///
class PinkPlatform extends MyPlatform {
  final double speed;
  late double travelRadius;
  bool upDirection = false;
  double traveled = 0;

  PinkPlatform({
    required super.xAxis,
    required super.yAxis,
    required this.speed,
    required super.width,
    required super.height,
    super.score = 30,
    required this.travelRadius,
  }) : super(type: PlatformType.pink);

  /// Moves the platform vertically based on its speed and travel radius.
  /// The platform alternates its direction (up or down) when it reaches
  /// the maximum or minimum extent of its travel radius
  void movePlatform() {
    if (upDirection) {
      traveled += speed;
      yAxis += speed;
      if (traveled >= travelRadius) {
        upDirection = false;
      }
    } else {
      traveled -= speed;
      yAxis -= speed;
      if (traveled <= -travelRadius) {
        upDirection = true;
      }
    }
  }

  @override
  Color get color {
    return Colors.pink;
  }
}
