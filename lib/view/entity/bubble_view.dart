import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/bubble.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A widget [BubbleView] that visualizes a Bubble in the game.
///
/// It extends [EntityView] to render [Bubble] entities using an image asset, which is specified during construction.
class BubbleView extends EntityView {
  final String imagePath;

  const BubbleView(Bubble bubble, {required this.imagePath, super.key})
      : super(entity: bubble);

  @override
  Widget buildEntityWidget() {
    return Image.asset(imagePath, fit: BoxFit.fill);
  }
}
