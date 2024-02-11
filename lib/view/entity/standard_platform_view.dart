import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/my_platform.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A [StandardPlatformView] widget that provides a visual representation for a standard platform in the game.
///
/// It extends [EntityView] to render [MyPlatform] entities as part of the game's user interface.
class StandardPlatformView extends EntityView {
  const StandardPlatformView(MyPlatform platform, {super.key})
      : super(entity: platform);

  @override
  Widget buildEntityWidget() {
    MyPlatform platform = entity as MyPlatform;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: platform.color,
      ),
    );
  }
}
