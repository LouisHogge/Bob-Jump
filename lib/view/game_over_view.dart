import 'package:flutter/material.dart';

/// [GameOverView], stateless widget, presents the game over screen with
/// the player's current score, best score, and some images.
/// It allows the user to go back to the menu.
class GameOverView extends StatelessWidget {
  final int score;
  final int bestScore;

  const GameOverView({super.key, required this.score, required this.bestScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/cloud.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                    fontFamily: 'Pacifico',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Best Score: $bestScore',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Tap anywhere to go back to the menu',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bob-c.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Image.asset(
                      'assets/pat-bob.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Image.asset(
                      'assets/pat-c.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
