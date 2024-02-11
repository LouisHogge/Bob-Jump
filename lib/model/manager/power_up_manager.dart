// import 'dart:math';

import 'package:bob_jump/model/entity/bouncer.dart';
import 'package:bob_jump/model/entity/my_hero.dart';
import 'package:bob_jump/model/entity/power_up.dart';
import 'package:bob_jump/model/entity/shield.dart';
import 'package:bob_jump/model/manager/manager.dart';

/// The [PowerUpManager] class, extending [Manager]<MyPowerUp>`, manages power-ups in the game.
///
/// It is responsible for adding, consuming, and deleting power-ups based on interactions
/// with the hero character. The class handles different types of power-ups, each with unique
/// properties and effects, managing their presence and effects in the game.

class PowerUpManager extends Manager<MyPowerUp> {
  static const Map<PowerUpType, Map<String, double>> _powerUpSize = {
    PowerUpType.flyer: {
      'widthFactor': 0.3,
      'heightFactor': 0.10,
    }, // rainbow
    PowerUpType.trampoline: {
      'widthFactor': 0.25,
      'heightFactor': 0.1,
    }, //jellyfish
    PowerUpType.shoes: {
      'widthFactor': 0.11,
      'heightFactor': 0.05,
    }, // Sponge
    PowerUpType.shield: {
      'widthFactor': 0.15,
      'heightFactor': 0.05,
    }, // burger
  };

  PowerUpManager({required super.screenWidth, required super.screenHeight});

  /// Updates the state of power-ups each tick.
  ///
  /// This method is called regularly (each tick) to process power-up consumption,
  /// check for deletions, and manage the overall state of power-ups in relation to the hero.
  void tick(MyHero hero) {
    _consume(hero);
    _delete(hero);
    deleteComponent();
  }

  /// Deletes power-ups under certain conditions.
  ///
  /// Removes power-ups from the game if specific conditions related to the hero's
  /// current power-ups are met.
  void _delete(MyHero hero) {
    for (MyPowerUp powerUp in components) {
      if (hero.isPowered(PowerUpType.flyer) ||
          hero.isPowered(PowerUpType.shoes) ||
          hero.isPowered(PowerUpType.trampoline)) {
        powerUp.destroy(screenHeight: screenHeight);
      }
    }
  }

  /// Processes the consumption of power-ups by the hero.
  ///
  /// When a power-up is collected, this method applies its effects to the hero, such as
  /// jump boosts or immunity, and then destroys the power-up.
  void _consume(MyHero hero) {
    for (MyPowerUp powerUp in components) {
      if (powerUp.collected) {
        if (!hero.isPowered(powerUp.getType())) {
          hero.addPower(powerUp);
        }
        if (powerUp is Bouncer) {
          hero.jumpBoost = hero.jumpSize * powerUp.multiplicator;
          hero.boostDuration = powerUp.use;
        } else if (powerUp is Shield) {
          hero.immunityDuration += powerUp.numberOfImmunity;
        }
        powerUp.destroy(screenHeight: screenHeight);
      }
    }
  }

  void addPowerUpTrampoline(double x, double y) {
    double width =
        _powerUpSize[PowerUpType.trampoline]!['widthFactor']! * screenWidth;
    double height =
        _powerUpSize[PowerUpType.trampoline]!['heightFactor']! * screenHeight;

    components.add(Bouncer(
      xAxis: x,
      yAxis: y,
      multiplicator: 10,
      score: 80,
      use: 1,
      width: width,
      height: height,
      type: PowerUpType.trampoline,
    ));
  }

  void addPowerUpShoes(double x, double y) {
    double width =
        _powerUpSize[PowerUpType.shoes]!['widthFactor']! * screenWidth;
    double height =
        _powerUpSize[PowerUpType.shoes]!['heightFactor']! * screenHeight;

    components.add(Bouncer(
      xAxis: x,
      yAxis: y + screenHeight * 0.05,
      multiplicator: 3,
      score: 50,
      use: 3,
      width: width,
      height: height,
      type: PowerUpType.shoes,
    ));
  }

  void addPowerUpFlyer(double x, double y) {
    double width =
        _powerUpSize[PowerUpType.flyer]!['widthFactor']! * screenWidth;
    double height =
        _powerUpSize[PowerUpType.flyer]!['heightFactor']! * screenHeight;

    components.add(Bouncer(
      xAxis: x,
      yAxis: y + screenHeight * 0.05,
      multiplicator: 20,
      score: 100,
      use: 1,
      width: width,
      height: height,
      type: PowerUpType.flyer,
    ));
  }

  void addShield(double x, double y) {
    double width =
        _powerUpSize[PowerUpType.shield]!['widthFactor']! * screenWidth;
    double height =
        _powerUpSize[PowerUpType.shield]!['heightFactor']! * screenHeight;

    components.add(Shield(
        xAxis: x,
        yAxis: y + screenHeight * 0.05,
        width: width,
        numberOfImmunity: 2,
        height: height,
        score: 60));
  }
}
