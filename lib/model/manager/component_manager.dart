import 'package:bob_jump/model/entity/my_hero.dart';
import 'package:bob_jump/model/manager/monster_manager.dart';
import 'package:bob_jump/model/manager/platform_manager.dart';
import 'package:bob_jump/model/manager/power_up_manager.dart';

/// The [ComponentManager] class consolidates the management of different game components.
///
/// It integrates various managers like [PlatformManager], [PowerUpManager], and [MonsterManager],
/// providing a unified interface for managing these components within the game. This class
/// coordinates the updates and scoring across different types of game components.

class ComponentManager {
  final PlatformManager _platformManager;
  final PowerUpManager _powerUpManager;
  final MonsterManager _monsterManager;
  final double screenHeight;
  final double screenWidth;
  ComponentManager({required this.screenWidth, required this.screenHeight})
      : _platformManager = PlatformManager(
            screenWidth: screenWidth, screenHeight: screenHeight),
        _powerUpManager = PowerUpManager(
            screenWidth: screenWidth, screenHeight: screenHeight),
        _monsterManager = MonsterManager(
            screenWidth: screenWidth, screenHeight: screenHeight);

  PlatformManager get getPlatformManager => _platformManager;

  PowerUpManager get getPowerUpManager => _powerUpManager;

  MonsterManager get getMonsterManger => _monsterManager;

  /// Updates the state of all managed components each tick.
  ///
  /// This method calls the tick methods of each individual manager, ensuring that platforms,
  /// power-ups, and monsters are updated based on the current state of the hero and the game.
  void tick(MyHero hero) {
    _platformManager.tick();
    _powerUpManager.tick(hero);
    _monsterManager.tick();
  }

  /// Calculates and returns the total score based on the game level.
  ///
  /// The method computes the score by multiplying the sum of individual scores from each
  /// manager by a level-based multiplier. This approach reflects the increasing challenge
  /// and rewards at higher levels.
  int getScore(int level) {
    int mul = 1;
    if (level < 6) {
      mul = 1;
    } else if (level < 11) {
      mul = 2;
    } else if (level < 16) {
      mul = 3;
    }
    return mul *
        (_platformManager.getScore() +
            _monsterManager.getScore() +
            _powerUpManager.getScore());
  }
}
