import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:bob_jump/controller/accelerometer_controller.dart';
import 'package:bob_jump/controller/sharedpreferences_controller.dart';
import 'package:bob_jump/controller/sound_controller.dart';
import 'package:bob_jump/model/game_model.dart';
import 'package:bob_jump/view/view.dart';

/// A stateful widget that represents the game screen.
///
/// [GameScreen] initializes the game state and provides the necessary context
/// for the game to run. It uses [GameControllerProvider] to manage the game's
/// logic and state.
class GameScreen extends StatefulWidget {
  final BuildContext context;

  const GameScreen(this.context, {Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

/// The state class associated with [GameScreen].
///
/// [_GameScreenState] handles [_initializeGameController] and [build] the
/// game view.
class _GameScreenState extends State<GameScreen> {
  late GameControllerProvider _gameController;

  @override
  void initState() {
    super.initState();
    _initializeGameController();
  }

  void _initializeGameController() {
    double screenWidth = MediaQuery.of(widget.context).size.width;
    double screenHeight = MediaQuery.of(widget.context).size.height;

    final routeArguments = ModalRoute.of(widget.context)?.settings.arguments
        as Map<dynamic, dynamic>?;
    final character = routeArguments?['character'] ?? 1;
    final level = routeArguments?['level'] ?? 1;
    _gameController = GameControllerProvider(
        screenWidth, screenHeight, level, context, character);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameControllerProvider>(
      create: (_) => _gameController,
      child: Viewed(_gameController.character),
    );
  }
}

/// A provider class that encapsulates the logic and state of the game.
///
/// [GameControllerProvider] manages [_loadChoice] from user, [_startTimer],
/// [_updateGameState], [_updatePlayerMovement] and handles
/// [didChangeAppLifecycleState].
///
/// It also deals with the game life with [_startGame], [pauseGame],
/// [resumeGame] and [_handleGameOver].
class GameControllerProvider with ChangeNotifier, WidgetsBindingObserver {
  late PreferencesService _prefsService;
  Timer? _timer;
  final GameModel _gameModel;
  late AccelSubscription accel;
  bool _isPaused = false;
  BuildContext context;
  bool isVibrationEnabled = true;
  static const frameDuration = Duration(milliseconds: 16);
  int character;

  GameControllerProvider(
      double width, double height, int level, this.context, this.character)
      : _gameModel = GameModel(width, height, level) {
    accel = AccelSubscription();
    _loadChoice();
    AudioPlayerManager().playGameMusic();
    _startGame();
    WidgetsBinding.instance.addObserver(this);
  }

  bool get isPaused => _isPaused;

  GameModel get gameModel => _gameModel;

  Future<void> _loadChoice() async {
    _prefsService = PreferencesService();

    bool savedVibration = await _prefsService.loadChoice("vibration", true);
    isVibrationEnabled = savedVibration;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    var audioPlayer = AudioPlayerManager().player;
    if (state == AppLifecycleState.paused) {
      audioPlayer.pause();
      pauseGame();
    } else if (state == AppLifecycleState.resumed) {
      audioPlayer.play();
      resumeGame();
    }
  }

  void _handleGameOver() {
    if (isVibrationEnabled) {
      Vibration.vibrate();
    }

    _timer?.cancel();
    accel.pause();
    int score = _gameModel.getGameState.getScore;
    var audioPlayer = AudioPlayerManager().player;
    audioPlayer.stop();
    Navigator.pushReplacementNamed(context, '/gameOver',
        arguments: {'score': score});
  }

  void _startGame() {
    _startTimer();
    accel.start();
  }

  void pauseGame() {
    if (!_isPaused) {
      _timer?.cancel();
      accel.pause();
      _isPaused = true;
      notifyListeners();
    }
  }

  void resumeGame() {
    if (_isPaused) {
      _startTimer();
      accel.resume();
      _isPaused = false;
      notifyListeners();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(frameDuration, (timer) {
      _updateGameState();
      _updatePlayerMovement();
    });
  }

  void _updatePlayerMovement() {
    _gameModel.moveHero(accel.getTargetXAxis, 0);
  }

  void _updateGameState() {
    if (_gameModel.tick()) {
      _handleGameOver();
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    accel.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }
}
