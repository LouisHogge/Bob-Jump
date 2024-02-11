import 'package:bob_jump/model/entity/component.dart';

enum PowerUpType { trampoline, shoes, flyer, shield, none }

/// Abstract class [MyPowerUp], extending [Component], represents a power-up in the game.
///
/// This class serves as a base for different types of power-ups, each with unique effects.
/// It includes common attributes like collection status.
///
abstract class MyPowerUp extends Component {
  bool collected = false;

  MyPowerUp({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    required super.score,
  });

  int get getScore => score;

  bool get getCollected => collected;

  void collect() {
    collected = true;
  }

  PowerUpType getType();
}
