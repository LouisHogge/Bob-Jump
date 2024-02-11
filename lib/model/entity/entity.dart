/// Abstract class [Entity] representing a general entity in the game.
///
/// This base class defines fundamental properties like position and dimensions.
/// It provides methods to [move] or [teleport] the entity within the game world,
/// serving as a foundation for more specific game entities.

abstract class Entity {
  double xAxis;
  double yAxis;
  final double width;
  final double height;

  Entity({
    required this.xAxis,
    required this.yAxis,
    required this.width,
    required this.height,
  });

  void move(double dx, double dy) {
    xAxis += dx;
    yAxis += dy;
  }

  void teleport(double x, double y) {
    xAxis = x;
    yAxis = y;
  }

  /* Using Dart's getter syntax for accessing entity properties. */
  double get getXAxis => xAxis;

  double get getYAxis => yAxis;

  double get getWidth => width;

  double get getHeight => height;
}
