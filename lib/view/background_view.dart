import 'package:flutter/material.dart';

/// [BackgroundView], simple stateless widget, [build] a background color.
class BackgroundView extends StatelessWidget {
  const BackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}
