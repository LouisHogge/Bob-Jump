import 'package:bob_jump/model/entity/component.dart';

/// Abstract class [Manager]<T>, where T is a subtype of [Component].
///
/// This class serves as a generic manager for game components. It handles the
/// initialization, tracking, and deletion of components based on their position
/// and state in the game. The class also manages scoring associated with components.

abstract class Manager<T extends Component> {
  final double screenWidth;
  final double screenHeight;
  int storedScore = 0;
  final List<T> components = [];

  Manager({required this.screenWidth, required this.screenHeight});

  List<T> get getComponent => components;

  /// Retrieves and resets the accumulated score.
  ///
  /// Returns the current stored score, then resets the [storedScore] to zero.
  /// This method is used to fetch the score accumulated from deleted components.
  int getScore() {
    int tmp = storedScore;
    storedScore = 0;
    return tmp;
  }

  /// Deletes components that meet certain criteria and updates the score.
  ///
  /// Iterates through the components, removing those that have moved off-screen
  /// (y-axis < 0). The score associated with each deleted component is added to
  /// [storedScore].

  void deleteComponent() {
    List<T> itemsToRemove = [];

    for (T item in components) {
      if (item.yAxis < 0) {
        storedScore += item.score;
        itemsToRemove.add(item);
      }
    }

    components.removeWhere((item) => itemsToRemove.contains(item));
  }
}
