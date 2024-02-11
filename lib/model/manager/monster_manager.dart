import 'dart:math';

import 'package:bob_jump/model/entity/my_monster.dart';
import 'package:bob_jump/model/manager/manager.dart';

/// The [MonsterManager] class, extending [Manager]<MyMonster>, manages monsters in the game.
///
/// It is responsible for adding, updating, and deleting monsters based on game dynamics.
/// This class handles the creation of monsters with varying sizes and types, maintaining
/// them within the game world and managing their lifecycle.

class MonsterManager extends Manager<MyMonster> {
  static const Map<int, Map<String, double>> _monsterSize = {
    0: {'widthFactor': 0.15, 'heightFactor': 0.1}, // Plankton1
    1: {'widthFactor': 0.2, 'heightFactor': 0.1}, // Plankton2
    2: {'widthFactor': 0.15, 'heightFactor': 0.1}, // Plankton3
    3: {'widthFactor': 0.15, 'heightFactor': 0.1}, // Puff
  };
  static const int numberOfType = 4;

  MonsterManager({required super.screenWidth, required super.screenHeight});

  /// Updates the state of monsters each tick.
  ///
  /// This method is called regularly (each tick) to perform checks on the monsters,
  /// such as their need for deletion.
  void tick() {
    deleteComponent();
  }

  void addMonster(double x, double y) {
    int type = Random().nextInt(numberOfType);
    double width = _monsterSize[type]!['widthFactor']! * screenWidth;
    double height = _monsterSize[type]!['heightFactor']! * screenHeight;

    components.add(MyMonster(
        xAxis: x,
        yAxis: y,
        width: width,
        height: height,
        type: type,
        score: 100));
  }
}
