import 'package:bob_jump/model/manager/component_manager.dart';
import 'package:bob_jump/model/game_generation.dart';
import 'package:bob_jump/model/game_state.dart';
import 'package:bob_jump/model/manager/bubble_manager.dart';
import 'package:bob_jump/model/manager/hero_manager.dart';
import 'package:bob_jump/model/physics_engine.dart';

/// Central model class for managing the state and components of the game.
///
/// [GameModel] integrates various managers and engines, like [PhysicsEngine],
/// [GameState], [HeroManager], [GameGeneration], [ComponentManager],
/// and [BubbleManager], to control the game's logic, including physics,
/// scoring, and entity management.
class GameModel {
  final PhysicsEngine _physicsEngine;
  final GameState _gameState;
  final HeroManager _heroManager;
  final GameGeneration _gameGeneration;
  final ComponentManager _componentManager;
  final BubbleManager _bubbleManager;

  GameModel(double width, double height, int level)
      : _physicsEngine =
            PhysicsEngine(screenWidth: width, screenHeight: height),
        _gameState = GameState(),
        _heroManager = HeroManager(screenWidth: width, screenHeight: height),
        _gameGeneration = GameGeneration(
            screenWidth: width, screenHeight: height, level: level),
        _componentManager =
            ComponentManager(screenWidth: width, screenHeight: height),
        _bubbleManager =
            BubbleManager(screenWidth: width, screenHeight: height) {
    _prepareNewGame(level);
  }

  ComponentManager get getComponentManager => _componentManager;

  GameState get getGameState => _gameState;

  HeroManager get getHeroManager => _heroManager;

  BubbleManager get getBubbleManager => _bubbleManager;

  void _prepareNewGame(int level) {
    _componentManager.getPlatformManager.generateFirstPlatforms();
    _bubbleManager.initializeBubble(level);
  }

  /// Executes a game tick, updating physics, game state, and all
  /// game components. Returns a boolean indicating if the game is over.
  bool tick() {
    _physicsEngine.tick(
        _heroManager.getHero, _componentManager, _bubbleManager);
    _bubbleManager.tick();
    _componentManager.tick(_heroManager.getHero);
    _gameGeneration.generateLevel(
        _componentManager.getPlatformManager,
        _componentManager.getPowerUpManager,
        _componentManager.getMonsterManger,
        _physicsEngine,
        _bubbleManager);

    _gameState
        .updateScore(_componentManager.getScore(_gameGeneration.getLevel));

    return _gameState.tick(_heroManager.getHero);
  }

  void moveHero(double dx, double dy) {
    _heroManager.moveHero(dx, dy);
  }
}
