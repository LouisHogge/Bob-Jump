import 'package:bob_jump/model/entity/power_up.dart';

/// The [Shield] class, extending [MyPowerUp], represents a shield power-up in the game.
///
/// It provides a specific number of immunity instances to the player. The class
/// initializes the power-up with spatial properties, immunity count, and a score value.

class Shield extends MyPowerUp {
  int numberOfImmunity;

  Shield({
    required super.xAxis,
    required super.yAxis,
    required this.numberOfImmunity,
    super.score = 40,
    required super.width,
    required super.height,
  });

  @override
  PowerUpType getType() {
    return PowerUpType.shield;
  }
}
