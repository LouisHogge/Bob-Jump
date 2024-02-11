import 'package:bob_jump/controller/sharedpreferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:bob_jump/controller/sound_controller.dart';
import 'package:bob_jump/view/game_over_view.dart';

/// A stateful widget for the game over screen.
///
/// [GameOverScreen] manages the state and behavior of the game over screen.
class GameOverScreen extends StatefulWidget {
  const GameOverScreen({super.key});

  @override
  GameOverScreenState createState() => GameOverScreenState();
}

/// The state class associated with [GameOverScreen].
///
/// [GameOverScreenState], [_initialize] game over screen data,
/// [_handleRouteArguments], [_loadBestScore] and [_updateBestScoreIfNeeded].
/// It observes the widget's lifecycle and reacts with
/// [didChangeAppLifecycleState].
class GameOverScreenState extends State<GameOverScreen>
    with WidgetsBindingObserver {
  late int bestScore = 0;
  late int score = 0;
  late PreferencesService _prefsService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  Future<void> _initialize() async {
    _prefsService = PreferencesService();
    await AudioPlayerManager().playGameOverMusic();
    await _loadBestScore();
    _handleRouteArguments();
  }

  Future<void> _handleRouteArguments() async {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    int newScore = routeArguments?['score'] ?? 0;
    if (mounted) {
      setState(() {
        score = newScore;
        _updateBestScoreIfNeeded(newScore);
      });
    }
  }

  Future<void> _loadBestScore() async {
    int storedBestScore = await _prefsService.loadChoice("bestScore", 0);
    if (storedBestScore != bestScore) {
      if (mounted) {
        setState(() {
          bestScore = storedBestScore;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) return;

    var audioPlayer = AudioPlayerManager().player;
    if (state == AppLifecycleState.paused) {
      audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      audioPlayer.play();
    }
  }

  Future<void> _updateBestScoreIfNeeded(int newScore) async {
    if (newScore > bestScore) {
      _prefsService.saveChoice('bestScore', newScore);
      if (mounted) {
        setState(() {
          bestScore = newScore;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayer = AudioPlayerManager().player;
    return GestureDetector(
        onTap: () {
          audioPlayer.stop();
          Navigator.pushReplacementNamed(context, '/homeMenu');
        },
        child: GameOverView(
          score: score,
          bestScore: bestScore,
        ));
  }
}
