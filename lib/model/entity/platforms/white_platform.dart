import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';

/// The [WhitePlatform] Class, extending [MyPlatform], represents a white platform in the game.
///
/// This platform type is characterized by its specific color (white) and a default score value.

class WhitePlatform extends MyPlatform {
  WhitePlatform({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    super.score = 20,
  }) : super(type: PlatformType.white);

  @override
  Color get color {
    return Colors.white;
  }
}
