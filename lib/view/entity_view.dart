import 'package:flutter/material.dart';
import 'package:bob_jump/model/entity/entity.dart';

/// [EntityView], abstract widget, is designed to represent various entities.
abstract class EntityView extends StatelessWidget {
  final Entity entity;

  const EntityView({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: entity.getYAxis - entity.height / 2,
        left: entity.getXAxis - entity.width / 2,
        child: SizedBox(
          height: entity.height,
          width: entity.width,
          child: buildEntityWidget(),
        ));
  }

  /// [buildEntityWidget], abstract method to be implemented by subclasses
  Widget buildEntityWidget();
}
