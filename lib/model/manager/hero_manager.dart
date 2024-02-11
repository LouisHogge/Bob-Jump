import 'package:bob_jump/model/entity/my_hero.dart';

/// The [HeroManager] class manages the hero character in the game environment.
///
/// It is responsible for the initialization, positioning, and movement of the hero
/// character based on the game's screen dimensions. This class encapsulates the
/// hero's properties and provides methods for manipulating the hero's position.

class HeroManager {
  final MyHero _hero;

  static const double startingXPositionFactor = 0.5;
  static const double startingYPositionFactor = 0.25;

  static const double heroWidthFactor = 0.15;
  static const double heroHeightFactor = 0.075;

  final double screenWidth;
  final double screenHeight;

  HeroManager({required this.screenWidth, required this.screenHeight})
      : _hero = MyHero(
          startingXPositionFactor * screenWidth,
          startingYPositionFactor * screenHeight,
          heroWidthFactor * screenWidth,
          heroHeightFactor * screenHeight,
        );

  MyHero get getHero => _hero;

  double get heroX => _hero.getXAxis;

  double get heroY => _hero.getYAxis;

  double get heroWidth => _hero.getWidth;

  double get heroHeight => _hero.getHeight;

  /// Moves the hero within the game world.
  ///
  /// Adjusts the hero's position based on the given deltas (dx, dy), while handling
  /// screen boundary conditions to ensure the hero remains within the visible game area.
  void moveHero(double dx, double dy) {
    if (_hero.getXAxis > (1 + heroWidthFactor / 2) * screenWidth) {
      _hero.move(-(1 + heroWidthFactor) * screenWidth, dy);
    } else if (_hero.getXAxis < -(heroWidthFactor / 2) * screenWidth) {
      _hero.move((1 + heroWidthFactor) * screenWidth, dy);
    } else {
      _hero.move(dx, dy);
    }
  }
}
