import 'package:flutter/material.dart';

/// The [ScoreView] class is a stateless widget responsible for displaying
/// the current game score. It uses custom styling to present the score
/// prominently within the game's UI.
class ScoreView extends StatelessWidget {
  final int score;

  const ScoreView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-0.9, -0.95),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
      child: Text(
        score.toString(),
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.12,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: [Colors.red, Colors.blue],
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 100.0, 80.0)),
          shadows: const [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ], // Add shadow
        ),
      ),
    );
  }
}
