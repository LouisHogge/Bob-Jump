import 'package:bob_jump/model/entity/power_up.dart';

/// The [Bouncer] class, extending [MyPowerUp], represents a power-up in the game.
///
/// It features a multiplicator for the power-up effect, a usage count,
/// and a specific [PowerUpType].
/// This class handles the initialization of these properties and manage
/// the getter for the [PowerUpType] of the `Bouncer`.

class Bouncer extends MyPowerUp {
  final double multiplicator;
  final int use;
  final PowerUpType type;

  Bouncer({
    required super.xAxis,
    required super.yAxis,
    required this.multiplicator,
    required super.score,
    required this.use,
    required super.width,
    required super.height,
    required this.type,
  });

  PowerUpType getType() {
    return type;
  }
}
