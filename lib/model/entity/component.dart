import 'package:bob_jump/model/entity/entity.dart';

/// Abstract class [Component], extending [Entity], represents a generic game component.
///
/// This base class is designed for various game components such as platforms, monsters,
/// and power-ups. It incorporates basic entity properties and introduces a score attribute,
/// relevant for different game mechanics.

abstract class Component extends Entity {
  int score;
  Component(
      {required super.xAxis,
      required super.yAxis,
      required super.width,
      required super.height,
      required this.score});

  /// Destroys the component by moving it off-screen.
  ///
  /// This method repositions the component well outside the visible game area,
  /// effectively removing it from active gameplay.
  void destroy({required double screenHeight}) {
    teleport(0, -2 * screenHeight);
  }
}
