import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bob_jump/controller/sharedpreferences_controller.dart';

/// Manages audio playback within the application.
///
/// [AudioPlayerManager] is a singleton that encapsulates the functionality
/// to play different audio tracks with [playMenuMusic], [playGameMusic],
/// and [playGameOverMusic].
/// It uses the [AssetsAudioPlayer] for handling audio playback.
class AudioPlayerManager {
  static final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  late PreferencesService _prefsService;

  factory AudioPlayerManager() {
    return _instance;
  }

  AudioPlayerManager._internal() {
    _prefsService = PreferencesService();
  }

  AssetsAudioPlayer get player => _audioPlayer;

  Future<void> playMenuMusic() async {
    double savedSound = await _prefsService.loadChoice("sound", 0.5);
    await _audioPlayer.open(
      Audio('assets/menu.mp3'),
      autoStart: true,
      loopMode: LoopMode.single,
      volume: savedSound,
    );
  }

  Future<void> playGameMusic() async {
    double savedSound = await _prefsService.loadChoice("sound", 0.5);
    await _audioPlayer.open(
      Audio('assets/jeu.mp3'),
      autoStart: true,
      loopMode: LoopMode.single,
      volume: savedSound,
    );
  }

  Future<void> playGameOverMusic() async {
    double savedSound = await _prefsService.loadChoice("sound", 0.5);
    await _audioPlayer.open(
      Audio('assets/end.mp3'),
      autoStart: true,
      loopMode: LoopMode.single,
      volume: savedSound,
    );
  }
}
