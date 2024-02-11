import 'package:bob_jump/model/entity/component.dart';

/// A custom monster for the game, extending the [Component] class.
///
/// This [MyMonster] represents a monster entity, encapsulating details such as position,
/// size, and a type identifier that could influence its appearance and behavior.
class MyMonster extends Component {
  int type;

  MyMonster(
      {required super.xAxis,
      required super.yAxis,
      required super.width,
      required super.height,
      required super.score,
      required this.type});
}
