import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/platforms/brown_platform.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A [BrowPlatformView] widget that visualizes a BrownPlatform in the game.
///
/// It extends [EntityView] to render [BrowPlatform] entities using an AnimatedOpacity widget.
/// This widget is responsible for rendering the BrownPlatform with specific visual effects and properties.
class BrownPlatformView extends EntityView {
  const BrownPlatformView(BrownPlatform platform, {super.key})
      : super(entity: platform);

  @override
  Widget buildEntityWidget() {
    BrownPlatform platform = entity as BrownPlatform;

    return AnimatedOpacity(
      opacity: platform.getCollision ? 0.0 : 1.0,
      duration: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: platform.color,
        ),
      ),
    );
  }
}
