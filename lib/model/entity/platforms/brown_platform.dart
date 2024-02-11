import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';

/// The [BrownPlatform] class, extending [MyPlatform], represents a brown
/// platform in the game.
///
/// It includes a flag to track collisions and is initialized with spatial
/// properties and a score.
/// The class provides functionality to handle platform deletion upon collision.

class BrownPlatform extends MyPlatform {
  bool _collision = false;

  BrownPlatform({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    super.score = 20,
  }) : super(type: PlatformType.brown);

  void delete() {
    _collision = true;
  }

  get getCollision => _collision;

  @override
  Color get color {
    return Colors.brown;
  }
}
