import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/power_up.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A widget [PowerUpView] that provides a visual representation for the PowerUp entity in the game.
///
/// It extends [EntityView] to render [MyPowerUp] entities using an image asset, which is specified during construction.
class PowerUpView extends EntityView {
  final String imagePath;

  const PowerUpView(MyPowerUp powerUp, {required this.imagePath, super.key})
      : super(entity: powerUp);

  @override
  Widget buildEntityWidget() {
    return Image.asset(imagePath, fit: BoxFit.fill);
  }
}
