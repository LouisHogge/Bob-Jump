import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/my_hero.dart';
import 'package:bob_jump/model/entity/power_up.dart';
import 'package:bob_jump/view/entity_view.dart';

/// A widget that visualizes the Hero in the game.
///
/// This [HeroView] widget handles the rendering of the Hero entity, with different images
/// based on the Hero's direction and power-up status.
/// It extends [EntityView] to render [MyHero] entities using an image asset, which is specified during construction.

class HeroView extends EntityView {
  final String imageRightPath;
  final String imageLeftPath;
  final String imageShieldRightPath;
  final String imageShieldLeftPath;

  const HeroView(
    MyHero hero, {
    required this.imageRightPath,
    required this.imageLeftPath,
    required this.imageShieldRightPath,
    required this.imageShieldLeftPath,
    super.key,
  }) : super(entity: hero);

  @override
  Widget buildEntityWidget() {
    MyHero hero = entity as MyHero;
    return (hero.isPowered(PowerUpType.shield))
        ? (hero.faceRight ? buildImageShieldRight() : buildImageShieldLeft())
        : (hero.faceRight ? buildImageRight() : buildImageLeft());
  }

  Widget buildImageRight() {
    return Image.asset(imageRightPath, fit: BoxFit.fill);
  }

  Widget buildImageLeft() {
    return Image.asset(imageLeftPath, fit: BoxFit.fill);
  }

  Widget buildImageShieldRight() {
    return Image.asset(imageShieldRightPath, fit: BoxFit.fill);
  }

  Widget buildImageShieldLeft() {
    return Image.asset(imageShieldLeftPath, fit: BoxFit.fill);
  }
}
