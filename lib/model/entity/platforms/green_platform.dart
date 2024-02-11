import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';

/// The [GreenPlatform] class, extending [MyPlatform], represents a green
/// platform in the game.
///
/// This platform is initialized with spatial properties and an optional score.

class GreenPlatform extends MyPlatform {
  GreenPlatform({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    super.score = 10,
  }) : super(type: PlatformType.green);

  @override
  Color get color {
    return Colors.green;
  }
}
