import 'dart:math';

import 'package:bob_jump/model/entity/platforms/brown_platform.dart';
import 'package:bob_jump/model/entity/platforms/green_platform.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';
import 'package:bob_jump/model/entity/platforms/orange_platform.dart';
import 'package:bob_jump/model/entity/platforms/pink_platform.dart';
import 'package:bob_jump/model/entity/platforms/white_platform.dart';
import 'package:bob_jump/model/manager/manager.dart';

/// The [PlatformManager] class, extending [Manager]<MyPlatform>`, manages platforms in the game.
///
/// It handles the generation, movement, and deletion of various types of platforms based on game mechanics.
/// This class is responsible for creating platforms with specific behaviors and properties, maintaining
/// them within the game world, and managing their lifecycle.
class PlatformManager extends Manager<MyPlatform> {
  static const double platformWidthFactor = 0.20;
  static const double platformSizeFactor = 10;
  static const double platformHeightFactor =
      platformWidthFactor / platformSizeFactor;
  final Random random = Random();

  PlatformManager({required super.screenWidth, required super.screenHeight});

  get getPlatformWidthFactor => platformWidthFactor;

  get getPlatformHeightFactor => platformHeightFactor;

  /// Updates the state of platforms each tick.
  ///
  /// This method is called regularly (each tick) to reposition, move, and delete platforms
  /// as needed based on their type and position in the game world.
  void tick() {
    _rePositionPlatform();
    _movePlatform();
    deleteComponent();
  }

  /// Generates the initial set of platforms when the game starts.
  ///
  /// This method creates and positions the first platform(s) in the game, setting
  /// the stage for the player's initial interactions.
  void generateFirstPlatforms() {
    double x;
    x = 0.5 * screenWidth;
    components.add(GreenPlatform(
      xAxis: x,
      yAxis: screenHeight * 0.25,
      width: platformWidthFactor * screenWidth,
      height: platformHeightFactor * screenHeight,
    ));
  }

  MyPlatform getRandomPlatform(double dx, double dy) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    double x = random.nextDouble() * 5;

    if (x < 1) {
      return GreenPlatform(xAxis: dx, yAxis: dy, width: width, height: height);
    } else if (x < 2) {
      double speed = random.nextDouble() / 100 * screenWidth;
      return OrangePlatform(
          xAxis: dx, yAxis: dy, speed: speed, width: width, height: height);
    } else if (x < 3) {
      return BrownPlatform(xAxis: dx, yAxis: dy, width: width, height: height);
    } else if (x < 4) {
      return WhitePlatform(xAxis: dx, yAxis: dy, width: width, height: height);
    } else {
      double speed = random.nextDouble() / 200 * screenHeight;
      return PinkPlatform(
          xAxis: dx,
          yAxis: dy,
          speed: speed,
          width: width,
          height: height,
          travelRadius: screenHeight * 0.25);
    }
  }

  /// Repositions specific types of platforms based on their position and behavior.
  ///
  /// Adjusts the position and direction of platforms, particularly Orange platforms,
  /// based on their current location and movement behavior.
  void _rePositionPlatform() {
    for (MyPlatform platform in components) {
      if (platform is OrangePlatform) {
        if (platform.getXAxis > (1 - platformWidthFactor / 2) * screenWidth ||
            platform.getXAxis < (platformWidthFactor / 2) * screenWidth) {
          platform.changeDirection();
        }
      }
    }
  }

  /// Moves specific types of platforms.
  ///
  /// Iterates through the platforms, invoking their movement methods if they are
  /// Orange or Pink platforms, to simulate dynamic platform behavior in the game.
  void _movePlatform() {
    for (MyPlatform platform in components) {
      if (platform is OrangePlatform) {
        platform.movePlatform();
      } else if (platform is PinkPlatform) {
        {
          platform.movePlatform();
        }
      }
    }
  }

  void addGreenPlatform(double x, double y) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    components
        .add(GreenPlatform(xAxis: x, yAxis: y, width: width, height: height));
  }

  void addWhitePlatform(double x, double y) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    components
        .add(WhitePlatform(xAxis: x, yAxis: y, width: width, height: height));
  }

  void addBrownPlatform(double x, double y) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    components
        .add(BrownPlatform(xAxis: x, yAxis: y, width: width, height: height));
  }

  void addOrangePlatform(double x, double y, double minSpeed, double maxSpeed) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    double speed = (Random().nextDouble() * (maxSpeed - minSpeed) + minSpeed) /
        100 *
        screenWidth;
    components.add(OrangePlatform(
        xAxis: x, yAxis: y, width: width, height: height, speed: speed));
  }

  void addPinkPlatform(double x, double y, double minSpeed, double maxSpeed,
      double travelRadius) {
    double width = platformWidthFactor * screenWidth;
    double height = platformHeightFactor * screenHeight;
    double speed = (Random().nextDouble() * (maxSpeed - minSpeed) + minSpeed) /
        100 *
        screenWidth;
    components.add(PinkPlatform(
        xAxis: x,
        yAxis: y,
        width: width,
        height: height,
        speed: speed,
        travelRadius: travelRadius));
  }
}
