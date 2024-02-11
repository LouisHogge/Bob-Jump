import 'dart:math';

import 'package:bob_jump/model/manager/component_manager.dart';
import 'package:bob_jump/model/entity/bubble.dart';
import 'package:bob_jump/model/entity/entity.dart';
import 'package:bob_jump/model/entity/my_hero.dart';
import 'package:bob_jump/model/entity/my_monster.dart';
import 'package:bob_jump/model/entity/platforms/brown_platform.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';
import 'package:bob_jump/model/entity/platforms/white_platform.dart';
import 'package:bob_jump/model/entity/power_up.dart';
import 'package:bob_jump/model/manager/bubble_manager.dart';

/// The [PhysicsEngine] class handles the physical interactions and behaviors in the game.
///
/// It manages gravity, collisions, and movement mechanics for game entities like the hero,
/// monsters, platforms, and power-ups. This class is crucial for creating a realistic and
/// responsive game environment.
///
class PhysicsEngine {
  static const double gravity = 10;
  static const double baseTimeIncrement = 0.1;
  double timeIncrement = baseTimeIncrement;
  final double screenWidth;
  final double screenHeight;
  double _time = 0;
  bool _heroBlocked = false;
  late double initialSpeed;

  PhysicsEngine({required this.screenWidth, required this.screenHeight});

  /// Updates the physics state of the game each tick.
  ///
  /// Processes the physical interactions, such as gravity effects and collisions, for the hero,
  /// platforms, monsters, power-ups, and bubbles.
  void tick(
      MyHero hero, ComponentManager components, BubbleManager bubbleManager) {
    _checkCollisions(hero, components);
    _applyGravity(hero, components, bubbleManager);
  }

  /// Applies gravity to the hero and all game components.
  ///
  /// Adjusts the vertical position of the hero and other components based on the current state
  /// of gravity, the hero's powers, and their current position in the game world.
  void _applyGravity(
      MyHero hero, ComponentManager components, BubbleManager bubbleManager) {
    _time += timeIncrement;
    double initialSpeed;

    if (hero.powerList.isEmpty) {
      initialSpeed = sqrt(hero.jumpSize * screenHeight * gravity * 2);
    } else if (hero.powerList.contains(PowerUpType.flyer) ||
        hero.powerList.contains(PowerUpType.trampoline) ||
        hero.powerList.contains(PowerUpType.shoes)) {
      initialSpeed = sqrt(hero.jumpBoost * screenHeight * gravity * 2);
    } else {
      initialSpeed = sqrt(hero.jumpSize * screenHeight * gravity * 2);
    }

    double deltaY = (-gravity * _time + initialSpeed) * timeIncrement;
    hero.isFalling = deltaY < 0;
    _applyHeroGravity(hero, initialSpeed, deltaY);
    _applyPlatformsGravity(
        hero, components.getPlatformManager.getComponent, initialSpeed, deltaY);
    _applyMonsterGravity(
        hero, components.getMonsterManger.getComponent, initialSpeed, deltaY);
    _applyPowerUpsGravity(
        hero, components.getPowerUpManager.getComponent, initialSpeed, deltaY);
    _applyBubbleGravity(hero, bubbleManager.getBubbles, initialSpeed, deltaY);
  }

  void _applyBubbleGravity(
      MyHero hero, List<Bubble> bubbles, double speed, double deltaY) {
    if (!hero.isFalling && hero.getYAxis >= 0.5 * screenHeight) {
      if (_heroBlocked) {
        for (Bubble bubble in bubbles) {
          bubble.move(0, -deltaY / 2);
        }
      }
    }
  }

  void _applyPowerUpsGravity(
      MyHero hero, List<MyPowerUp> powerUps, double speed, double deltaY) {
    if (!hero.isFalling && hero.getYAxis >= 0.5 * screenHeight) {
      if (_heroBlocked) {
        for (MyPowerUp powerUp in powerUps) {
          powerUp.move(0, -deltaY);
        }
      }
    }
  }

  void _applyMonsterGravity(
      MyHero hero, List<MyMonster> monsters, double speed, double deltaY) {
    if (!hero.isFalling && hero.getYAxis >= 0.5 * screenHeight) {
      if (_heroBlocked) {
        for (MyMonster monster in monsters) {
          monster.move(0, -deltaY);
        }
      }
    }
  }

  void _applyPlatformsGravity(
      MyHero hero, List<MyPlatform> platforms, double speed, double deltaY) {
    if (!hero.isFalling && hero.getYAxis >= 0.5 * screenHeight) {
      if (_heroBlocked) {
        for (MyPlatform platform in platforms) {
          platform.move(0, -deltaY);
        }
      }
    }
  }

  void _applyHeroGravity(MyHero hero, double speed, double deltaY) {
    if (!hero.isFalling && hero.getYAxis >= 0.5 * screenHeight) {
      if (_heroBlocked) {
        hero.moveSupposedAxis(deltaY);
        if (hero.supposedAxis <= 0.5 * screenHeight) {
          _heroBlocked = false;
          hero.teleport(hero.getXAxis, hero.supposedAxis);
        }
      } else {
        hero.moveSupposedAxis(hero.yAxis);
        _heroBlocked = true;
      }
    } else {
      hero.move(0, deltaY);
    }
  }

  /// Checks for collisions between the hero and other game components.
  ///
  /// Processes potential collisions with platforms, monsters, and power-ups, triggering
  /// appropriate actions based on the type of collision.
  void _checkCollisions(MyHero hero, ComponentManager components) {
    _checkCollisionsPlatforms(hero, components.getPlatformManager.getComponent);
    _checkCollisionsMonsters(hero, components.getMonsterManger.getComponent);
    _checkCollisionsPowerUp(hero, components.getPowerUpManager.getComponent);
  }

  bool _horizontalCollision(Entity entity1, Entity entity2) {
    return entity1.getXAxis - entity1.getWidth / 2 <
            entity2.getXAxis + entity2.getWidth / 2 &&
        entity1.getXAxis + entity1.getWidth / 2 >
            entity2.getXAxis - entity2.getWidth / 2;
  }

  bool _verticalCollision(Entity entity1, Entity entity2) {
    return entity1.getYAxis - entity1.getHeight / 2 <
            entity2.getYAxis + entity2.getHeight / 2 &&
        entity1.getYAxis + entity1.getHeight / 2 >
            entity2.getYAxis - entity2.getHeight / 2;
  }

  bool _footCollision(Entity entityFoot, Entity entity2) {
    return entityFoot.getYAxis - entityFoot.getHeight / 2 <
            entity2.getYAxis + entity2.getHeight / 2 &&
        entityFoot.getYAxis - entityFoot.getHeight / 2 >
            entity2.getYAxis - entity2.getHeight / 2;
  }

  void _checkCollisionsPowerUp(MyHero hero, List<MyPowerUp> powerUps) {
    for (MyPowerUp powerUp in powerUps) {
      if (_horizontalCollision(hero, powerUp) &&
          _verticalCollision(hero, powerUp)) {
        if (powerUp.getType() == PowerUpType.shield) {
          powerUp.collect();
        } else {
          if (hero.isPowered(PowerUpType.flyer) ||
              hero.isPowered(PowerUpType.shoes) ||
              hero.isPowered(PowerUpType.trampoline)) {
            powerUp.destroy(screenHeight: screenHeight);
          } else {
            powerUp.collect();
          }
        }
      }
    }
  }

  void _checkCollisionsMonsters(MyHero hero, List<MyMonster> monsters) {
    for (MyMonster monster in monsters) {
      if (_horizontalCollision(hero, monster) &&
          _verticalCollision(hero, monster)) {
        if (hero.isFalling) {
          monster.destroy(screenHeight: screenHeight);
          jump(hero);
        } else {
          if (hero.isPowered(PowerUpType.shield)) {
            if (hero.immunityDuration == 1) {
              hero.immunityDuration == 0;
              hero.movePower(PowerUpType.shield);
              monster.destroy(screenHeight: screenHeight);
              jump(hero);
            } else if (hero.immunityDuration > 1) {
              hero.immunityDuration -= 1;
              monster.destroy(screenHeight: screenHeight);
              jump(hero);
            } else {
              hero.teleport(0, -2 * screenHeight);
            }
          } else if (hero.isPowered(PowerUpType.flyer) ||
              hero.isPowered(PowerUpType.trampoline)) {
            monster.destroy(screenHeight: screenHeight);
          } else {
            hero.teleport(0, -2 * screenHeight);
          }
        }
      }
    }
  }

  void _checkCollisionsPlatforms(MyHero hero, List<MyPlatform> platforms) {
    for (MyPlatform platform in platforms) {
      if (hero.isFalling &&
          _horizontalCollision(hero, platform) &&
          _footCollision(hero, platform)) {
        if (platform is BrownPlatform) {
          platform.delete();
        } else if (platform is WhitePlatform) {
          platform.destroy(screenHeight: screenHeight);
          jump(hero);
        } else {
          jump(hero);
        }
      }
    }
  }

  /// Adjusts the time increment used for gravity calculations.
  ///
  /// Modifies the rate at which time progresses in the game's physics calculations,
  /// allowing for dynamic adjustments to the gravity effect.
  void changeTimeIncrement(double newTime) {
    timeIncrement = newTime;
  }

  /// Triggers a jump action for the hero.
  ///
  /// This method is called when the hero interacts with certain platforms or power-ups,
  /// initiating a jump based on the hero's current power-up status and resetting the
  /// time counter for gravity calculations.
  void jump(MyHero hero) {
    if (hero.isPowered(PowerUpType.flyer) ||
        hero.isPowered(PowerUpType.trampoline) ||
        hero.isPowered(PowerUpType.shoes)) {
      if (hero.boostDuration == 1) {
        hero.boostDuration == 0;
        hero.movePower(PowerUpType.flyer);
        hero.movePower(PowerUpType.trampoline);
        hero.movePower(PowerUpType.shoes);
        _time = 0;
      } else if (hero.boostDuration > 1) {
        hero.boostDuration -= 1;
        _time = 0;
      }
    } else {
      _time = 0;
    }
  }
}
