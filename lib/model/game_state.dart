import 'package:bob_jump/model/entity/my_hero.dart';

/// The [GameState] class manages the state of the game, including score and game over conditions.
///
/// This class tracks the current score and checks for game-ending conditions based on the hero's
/// status. It provides methods to update the score and determine the game's ongoing status.

class GameState {
  int _score;
  bool _isGameOver = false;

  GameState({int score = 0}) : _score = score;

  int get getScore => _score;

  bool get getIsGameOver => _isGameOver;

  /// Updates the game state each tick, checking for game over conditions.
  ///
  /// Processes the hero's status to determine if the game has ended.
  /// Returns `true` if the game is over, otherwise `false`.
  bool tick(MyHero hero) {
    return _checkGameOver(hero);
  }

  /// Updates the game's score with additional points.
  ///
  /// Increments the [_score] by the given [points], provided the game is not over.
  void updateScore(int points) {
    if (!_isGameOver) {
      _score += points;
    }
  }

  /// Checks if the game is over based on the hero's position.
  ///
  /// Sets [_isGameOver] to `true` if the hero's y-axis position falls off-screen.
  /// Returns the updated game over status.
  bool _checkGameOver(MyHero hero) {
    if (hero.getYAxis <= 0) {
      _isGameOver = true;
    }
    return _isGameOver;
  }
}
