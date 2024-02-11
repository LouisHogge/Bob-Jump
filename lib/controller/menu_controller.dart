import 'package:flutter/material.dart';
import 'package:bob_jump/controller/sharedpreferences_controller.dart';
import 'package:bob_jump/view/menu_button_view.dart';
import 'package:bob_jump/controller/custom_dialog_controler.dart';
import 'package:bob_jump/view/custom_app_bar_view.dart';
import 'package:bob_jump/controller/sound_controller.dart';
import 'package:bob_jump/view/utils_view.dart';

/// A stateful widget for the main menu of the game.
///
/// [MainMenu] presents the main menu options. It manages user preferences
/// and interacts with various controllers for functionality.
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

/// The state class associated with [MainMenu].
///
/// [MainMenuState] handles [_initialize], [_loadChoice],
/// [didChangeAppLifecycleState], and several dialog presentation.
/// It utilizes [CustomDialog], [UtilsView], and [PreferencesService] for
/// various functionalities.
class MainMenuState extends State<MainMenu> with WidgetsBindingObserver {
  late PreferencesService _prefsService;
  late CustomDialog _customDialog;
  int character = 1;
  late double soundLevel = 0.5;
  bool isVibrationEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  Future<void> _initialize() async {
    _prefsService = PreferencesService();
    _customDialog = CustomDialog();
    await _loadChoice();
    await AudioPlayerManager().playMenuMusic();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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

  Future<void> _loadChoice() async {
    int savedCharacter = await _prefsService.loadChoice("characterChoice", 1);
    bool savedVibration = await _prefsService.loadChoice("vibration", true);
    double savedSound = await _prefsService.loadChoice("sound", 0.5);
    if (mounted) {
      setState(() {
        isVibrationEnabled = savedVibration;
        character = savedCharacter;
        soundLevel = savedSound;
      });
    }
  }

  /// [_showCharacterDialog] displays a dialog for character selection.
  void _showCharacterDialog(BuildContext context) {
    if (!mounted) return;

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    _customDialog.showDialogRequired(
      context: context,
      title: 'Choose your Hero!',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: InkWell(
              onTap: () {
                character = 1;
                _prefsService.saveChoice('characterChoice', 1);
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/bobRight.png'),
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                character = 2;
                _prefsService.saveChoice('characterChoice', 2);
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/patrickRight.png'),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF4CAF50),
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
    );
  }

  /// [_showParametersDialog] displays a dialog for adjusting game parameters.
  void _showParametersDialog(BuildContext context) {
    if (!mounted) return;

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    var audioPlayer = AudioPlayerManager().player;

    _customDialog.showDialogRequired(
      context: context,
      title: 'Parameters',
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03,
              horizontal: screenWidth * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sound Level: ${(soundLevel * 100).toStringAsFixed(0)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: soundLevel,
                      onChanged: (value) {
                        setState(() {
                          soundLevel = value;
                          audioPlayer.setVolume(soundLevel);
                          _prefsService.saveChoice('sound', soundLevel);
                        });
                      },
                      min: 0,
                      max: 1,
                      divisions: 100,
                      label: (soundLevel * 100).toStringAsFixed(0),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vibration:',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Switch(
                      value: isVibrationEnabled,
                      onChanged: (value) {
                        setState(() {
                          isVibrationEnabled = value;
                          _prefsService.saveChoice(
                              'vibration', isVibrationEnabled);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFFF8C00),
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
    );
  }

  /// [_showLevelDialog] displays a dialog for level difficulty selection.
  void _showLevelDialog(BuildContext context) {
    if (!mounted) return;

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    var audioPlayer = AudioPlayerManager().player;

    _customDialog.showDialogRequired(
      context: context,
      title: 'Select Difficulty',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                audioPlayer.stop();
                Navigator.pushReplacementNamed(context, '/game',
                    arguments: {'character': character, 'level': 1});
              },
              style: UtilsView.dialogButton(
                backgroundColor: Colors.green,
                verticalPadding: screenHeight * 0.03,
                horizontalPadding: screenWidth * 0.07,
              ),
              child: UtilsView.textWidget(
                  text: 'Easy',
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  audioPlayer.stop();
                  Navigator.pushReplacementNamed(context, '/game',
                      arguments: {'character': character, 'level': 6});
                },
                style: UtilsView.dialogButton(
                  backgroundColor: Colors.orange,
                  verticalPadding: screenHeight * 0.03,
                  horizontalPadding: screenWidth * 0.07,
                ),
                child: UtilsView.textWidget(
                    text: 'Medium',
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                audioPlayer.stop();
                Navigator.pushReplacementNamed(context, '/game',
                    arguments: {'character': character, 'level': 11});
              },
              style: UtilsView.dialogButton(
                backgroundColor: Colors.red,
                verticalPadding: screenHeight * 0.03,
                horizontalPadding: screenWidth * 0.07,
              ),
              child: UtilsView.textWidget(
                  text: 'Hard',
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFF6464),
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
    );
  }

  /// [_showDeveloperInfo] displays a dialog containing credits.
  void _showDeveloperInfo(BuildContext context) {
    if (!mounted) return;

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    _customDialog.showDialogRequired(
      context: context,
      title: 'Credits',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This code was developed as part of the Object-oriented programming on mobile devices course, under the supervision of Laurent Mathy.',
            style: TextStyle(
              color: Colors.green,
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Meet the Developers:',
            style: TextStyle(
              color: Colors.red,
              // Custom color
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Column(
            children: [
              UtilsView.buildDeveloperInfo(
                  context, 'Bounar Nadir', 'Master 2, Computer Scientist'),
              UtilsView.buildDeveloperInfo(
                  context, 'Hogge Louis', 'Master 1, Computer Engineer'),
              UtilsView.buildDeveloperInfo(
                  context, 'Romoli Raphaël', 'Master 1, Computer Engineer'),
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFB6C1),
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
    );
  }

  /// [build] the UI for the main menu.
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlue[100]!,
              Colors.lightBlue[200]!,
              Colors.lightBlue[300]!,
              Colors.lightBlue[400]!,
              Colors.lightBlue[500]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).padding.top + (0.03 * screenHeight),
              left: (0.02 * screenWidth),
              right: (0.02 * screenWidth),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.9,
                        child: CustomAppBar(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                          style: UtilsView.menuButton(color: Color(0xFF4CAF50)),
                          child: const MainMenuButtonView(
                            title: 'Character',
                            subtitle: 'Choose your Hero!',
                            icon: Icons.person,
                          ),
                          onPressed: () {
                            _showCharacterDialog(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                            onPressed: () {
                              _showLevelDialog(context);
                            },
                            style:
                                UtilsView.menuButton(color: Color(0xFFFF6464)),
                            child: const MainMenuButtonView(
                              title: 'Level',
                              subtitle: 'Beat us!',
                              icon: Icons.star,
                            )),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                            onPressed: () {
                              _showDeveloperInfo(context);
                            },
                            style:
                                UtilsView.menuButton(color: Color(0xFFFFB6C1)),
                            child: const MainMenuButtonView(
                              title: 'Credits',
                              subtitle: 'Know more about us',
                              icon: Icons.people,
                            )),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                            onPressed: () {
                              _showParametersDialog(context);
                            },
                            style:
                                UtilsView.menuButton(color: Color(0xFFFF8C00)),
                            child: const MainMenuButtonView(
                              title: 'Settings',
                              subtitle: 'Sound-Vibration',
                              icon: Icons.settings,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
