import 'package:bob_jump/model/entity/entity.dart';

enum BubbleType { blue, orange, red }

/// The `Bubble` class, extending `Entity`, represents a bubble in the game.
///
/// Each [Bubble] has a specific [BubbleType] (blue, orange, red) indicating its state.
/// The class provides functionality to manipulate these bubbles, including
/// initializing their properties and [increase] their type state.
///
class Bubble extends Entity {
  BubbleType type;

  Bubble({
    required super.xAxis,
    required super.yAxis,
    required super.width,
    required super.height,
    required this.type,
  });

  // Getter for type
  BubbleType get getType => type;

  /// Increasing their type state when triggered (when the difficuly augment)
  increase() {
    switch (type) {
      case BubbleType.red:
        break;
      case BubbleType.orange:
        type = BubbleType.red;
        break;
      case BubbleType.blue:
        type = BubbleType.orange;
        break;
      default:
        break;
    }
  }
}
