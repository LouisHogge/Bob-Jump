import 'package:bob_jump/model/entity/entity.dart';
import 'package:bob_jump/model/entity/power_up.dart';

/// Represents a hero character in the game, extending the `Entity` class.
///
/// The [MyHero] class embodies the main character with attributes like jump boost,
/// power-ups, immunity duration, and movement direction. It manages the hero's
/// abilities, states, and interactions with power-ups in the game environment.

class MyHero extends Entity {
  double jumpBoost = 0;
  int boostDuration = 0;
  bool faceRight = true;
  List<PowerUpType> powerList = [];
  int immunityDuration = 0;
  bool falling = true;
  double supposedYAxis;
  double jumpSize = 0.3;

  MyHero(double xAxis, double yAxis, double width, double height)
      : supposedYAxis = yAxis,
        super(xAxis: xAxis, yAxis: yAxis, width: width, height: height);

  /// Sets the falling status of the hero.
  set isFalling(bool isFalling) => falling = isFalling;

  /// Sets the duration of the hero's boost.
  ///
  /// This setter updates the [boostDuration] attribute, defining how long
  /// the boost effect will last for the hero.
  set setBoostDuration(int duration) => boostDuration = duration;

  /// Sets the jump boost value for the hero.
  ///
  /// This method assigns a new jump boost value to [jumpBoost], enhancing the
  /// hero's jumping capability in the game.
  set setJumpBoost(double boost) => jumpBoost = boost;

  /// Resets the power list of the hero.
  ///
  /// Clears all the power-ups currently held by the hero, resetting
  /// the [powerList] to an empty state.
  void reset() {
    powerList.clear();
  }

  /// Adds a new power-up to the hero's power list.
  ///
  /// This method includes a new power-up type in the hero's collection,
  /// expanding their abilities or attributes in the game.
  void addPower(MyPowerUp powerUp) {
    powerList.add(powerUp.getType());
  }

  /// Removes a specific power-up from the hero's power list.
  ///
  /// This method eliminates a particular power-up type from the hero's
  /// collection, reflecting the loss or usage of that power-up.
  void movePower(PowerUpType type) {
    powerList.remove(type);
  }

  /// Checks if the hero is powered by a specific type of power-up.
  ///
  /// Returns `true` if the hero currently has the specified power-up type,
  /// otherwise returns `false`.
  bool isPowered(PowerUpType type) {
    return powerList.contains(type);
  }

  /// Moves the supposed Y-axis of the hero by a given amount.
  ///
  /// This method adjusts the [supposedYAxis], simulating a vertical movement
  /// or positioning adjustment for the hero.
  void moveSupposedAxis(double dy) => supposedYAxis += dy;

  /// Teleports the hero to a specific Y-axis position.
  ///
  /// Directly sets the [supposedYAxis] to the specified position, effectively
  /// 'teleporting' the hero to that vertical location.
  void teleportSupposedAxis(double dy) => supposedYAxis = dy;

  @override
  void move(double dx, double dy) {
    if (dx > 0) {
      faceRight = true;
    } else {
      faceRight = false;
    }
    xAxis += dx;
    yAxis += dy;
  }

  int get getNumberOfImmunity => immunityDuration;

  double get getJumpBoost => jumpBoost;

  int get getBoostDuration => boostDuration;

  bool get isFalling => falling;

  bool get getFaceRight => faceRight;

  double get supposedAxis => supposedYAxis;

  double get jumpSizeValue => jumpSize;

  List<PowerUpType> get getPowerType => powerList;
}
