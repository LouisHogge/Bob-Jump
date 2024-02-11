import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/my_monster.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A widget [MonsterView] that provides a visual representation for the Monster entity in the game.
///
/// It extends [EntityView] to render [MyMonster] entities using an image asset, which is specified during construction.
class MonsterView extends EntityView {
  final String imagePath;

  const MonsterView(MyMonster monster, {required this.imagePath, super.key})
      : super(entity: monster);

  @override
  Widget buildEntityWidget() {
    return Image.asset(imagePath, fit: BoxFit.fill);
  }
}
