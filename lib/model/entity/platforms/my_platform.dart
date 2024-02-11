import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/component.dart';

enum PlatformType { brown, green, orange, white, pink }

/// Abstract class [MyPlatform] representing a generic platform in the game.
///
/// This class serves as a base for different types of platforms, each with unique
/// characteristics. It extends `Component` and incorporates
/// additional attributes and abstract methods specific to game platforms.

abstract class MyPlatform extends Component {
  final PlatformType type;

  MyPlatform({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    this.type = PlatformType.green,
    required super.score,
  });

  Color get color;
}
