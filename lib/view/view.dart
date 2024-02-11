import 'package:flutter/material.dart';
import 'package:bob_jump/controller/game_controller.dart';
import 'package:bob_jump/model/entity/bubble.dart';
import 'package:bob_jump/model/entity/bouncer.dart';
import 'package:bob_jump/model/entity/my_monster.dart';
import 'package:bob_jump/model/entity/platforms/brown_platform.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';
import 'package:bob_jump/model/entity/power_up.dart';
import 'package:bob_jump/model/entity/shield.dart';
import 'package:bob_jump/view/background_view.dart';
import 'package:bob_jump/view/entity/hero_view.dart';
import 'package:bob_jump/view/entity/bubble_view.dart';
import 'package:bob_jump/view/entity/powerup_view.dart';
import 'package:bob_jump/view/entity/monster_view.dart';
import 'package:bob_jump/controller/pause_controler.dart';
import 'package:bob_jump/view/entity/brown_platform_view.dart';
import 'package:bob_jump/view/entity/standard_platform_view.dart';
import 'package:bob_jump/view/score_view.dart';
import 'package:provider/provider.dart';

/// The [Viewed] class is a stateless widget that provides the main view
/// of the game. It manages the layout of various game components like
/// background, entities, score, and pause view.
class Viewed extends StatelessWidget {
  final int character;

  Viewed(this.character, {super.key});

  final BackgroundView background = const BackgroundView();
  final PauseView pause = PauseView();

  @override
  Widget build(BuildContext context) {
    return Consumer<GameControllerProvider>(
      builder: (context, controller, child) {
        return stackedView(controller: controller);
      },
    );
  }

  /// Creates a stacked view of game components such as background, entities,
  /// pause button, and score view, arranged based on the game state.
  Widget stackedView({required GameControllerProvider controller}) {
    final ScoreView score =
        ScoreView(score: controller.gameModel.getGameState.getScore);
    final Stack entities = entitiesWidget(controller: controller);

    return Stack(
      children: [background, entities, pause, score],
    );
  }

  /// Generates a stack of entity widgets, including bubbles, platforms,
  /// power-ups, monsters, and the hero character, based on the game controller's state.
  Stack entitiesWidget({required GameControllerProvider controller}) {
    return Stack(
      children: [
        stackBubble(controller: controller),
        stackPlatorm(controller: controller),
        stackPowerUp(controller: controller),
        stackMonster(controller: controller),
        _chooseHero(controller: controller)
      ],
    );
  }

  /// Builds a stack of bubble widgets, dynamically created based on the
  /// current state of bubbles in the game model.
  Widget stackBubble({required GameControllerProvider controller}) {
    return Stack(
      children: controller.gameModel.getBubbleManager.getBubbles.map((bubble) {
        return _chooseBubble(bubble: bubble);
      }).toList(),
    );
  }

  /// Chooses the appropriate bubble view based on the type of the bubble.
  /// Supports different bubble types like blue, orange, and red.
  Widget _chooseBubble({required Bubble bubble}) {
    if (bubble.getType == BubbleType.blue) {
      return BubbleView(bubble, imagePath: 'assets/blueBubble.png');
    } else if (bubble.getType == BubbleType.orange) {
      return BubbleView(bubble, imagePath: 'assets/orangeBubble.png');
    } else if (bubble.getType == BubbleType.red) {
      return BubbleView(bubble, imagePath: 'assets/redBubble.png');
    } else {
      return const SizedBox.shrink();
    }
  }

  /// Constructs a stack of power-up widgets, representing different types
  /// of power-ups available in the game, such as bouncer and shield.
  Widget stackPowerUp({required GameControllerProvider controller}) {
    return Stack(
      children: controller
          .gameModel.getComponentManager.getPowerUpManager.getComponent
          .map((powerUp) {
        return _choosePowerUp(powerUp: powerUp);
      }).toList(),
    );
  }

  /// Selects the appropriate power-up view based on the type of power-up.
  /// Handles different power-up types like flyer, shoes, and trampoline.
  Widget _choosePowerUp({required MyPowerUp powerUp}) {
    if (powerUp is Bouncer) {
      String imagePath;
      switch (powerUp.getType()) {
        case PowerUpType.flyer:
          imagePath = 'assets/rainbow.png';
          break;
        case PowerUpType.shoes:
          imagePath = 'assets/sponge.png';
          break;
        case PowerUpType.trampoline:
          imagePath = 'assets/jellyfish.png';
          break;
        default:
          imagePath = '';
          break;
      }
      return PowerUpView(powerUp, imagePath: imagePath);
    } else if (powerUp is Shield) {
      return PowerUpView(powerUp, imagePath: 'assets/hamburger.png');
    } else {
      return const SizedBox.shrink();
    }
  }

  /// Creates a stack of platform widgets, based on the current platforms
  /// present in the game model.
  Widget stackPlatorm({required GameControllerProvider controller}) {
    return Stack(
      children: controller
          .gameModel.getComponentManager.getPlatformManager.getComponent
          .map((platform) {
        return _choosePlatform(platform: platform);
      }).toList(),
    );
  }

  /// Chooses the right platform view, either a brown platform or a standard one,
  /// based on the specific instance of the platform.
  Widget _choosePlatform({required MyPlatform platform}) {
    if (platform is BrownPlatform) {
      return BrownPlatformView(platform);
    } else {
      return StandardPlatformView(platform);
    }
  }

  /// Builds a stack of monster widgets, creating views for each monster
  /// in the game model.
  Widget stackMonster({required GameControllerProvider controller}) {
    return Stack(
      children: controller
          .gameModel.getComponentManager.getMonsterManger.getComponent
          .map((monster) {
        return _chooseMonster(monster: monster);
      }).toList(),
    );
  }

  /// Selects the appropriate monster view based on the monster's type.
  /// Handles different monster types with corresponding assets.
  Widget _chooseMonster({required MyMonster monster}) {
    switch (monster.type) {
      case 0:
        return MonsterView(monster, imagePath: 'assets/plankton-1.png');
      case 1:
        return MonsterView(monster, imagePath: 'assets/plankton-2.png');
      case 2:
        return MonsterView(monster, imagePath: 'assets/plankton-3.png');
      case 3:
        return MonsterView(monster, imagePath: 'assets/puff.png');
      default:
        return MonsterView(monster, imagePath: 'assets/plankton-1.png');
    }
  }

  /// Determines and returns the hero view based on the selected character.
  /// Provides different hero views with unique assets for each character type.
  Widget _chooseHero({required GameControllerProvider controller}) {
    switch (character) {
      case 1:
        return HeroView(
          controller.gameModel.getHeroManager.getHero,
          imageRightPath: 'assets/bobRight.png',
          imageLeftPath: 'assets/bobLeft.png',
          imageShieldRightPath: 'assets/bobRightShield.png',
          imageShieldLeftPath: 'assets/bobLeftShield.png',
        );
      case 2:
        return HeroView(
          controller.gameModel.getHeroManager.getHero,
          imageRightPath: 'assets/patrickRight.png',
          imageLeftPath: 'assets/patrickLeft.png',
          imageShieldRightPath: 'assets/patrickRightShield.png',
          imageShieldLeftPath: 'assets/patrickLeftShield.png',
        );
      default:
        return HeroView(
          controller.gameModel.getHeroManager.getHero,
          imageRightPath: 'assets/bobRight.png',
          imageLeftPath: 'assets/bobLeft.png',
          imageShieldRightPath: 'assets/bobRightShield.png',
          imageShieldLeftPath: 'assets/bobLeftShield.png',
        );
    }
  }
}
