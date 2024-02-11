import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bob_jump/controller/game_controller.dart';
import 'package:bob_jump/controller/custom_dialog_controler.dart';
import 'package:bob_jump/view/utils_view.dart';

/// A widget for displaying and managing the pause functionality in the game.
///
/// [PauseView] presents a pause button [build] and handles [_showPauseDialog]
/// It interacts with [GameControllerProvider] to manage game state.
class PauseView extends StatelessWidget {
  final CustomDialog _customDialog = CustomDialog();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<GameControllerProvider>(context, listen: false);
    return Container(
      alignment: const Alignment(0.9, -0.95),
      child: ElevatedButton(
        onPressed: () {
          controller.pauseGame();
          _showPauseDialog(context, controller);
        },
        child: const Icon(
          Icons.pause,
        ),
      ),
    );
  }

  void _showPauseDialog(
      BuildContext context, GameControllerProvider controller) {
    _customDialog.showDialogRequired(
      context: context,
      title: 'Pause',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.resumeGame();
                },
                style: UtilsView.dialogButton(
                  backgroundColor: Colors.green,
                  verticalPadding: MediaQuery.of(context).size.height * 0.02,
                  horizontalPadding: MediaQuery.of(context).size.width * 0.02,
                ),
                child: UtilsView.textWidget(
                    text: 'Resume',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  controller.dispose();
                  Navigator.pushNamed(context, '/homeMenu');
                },
                style: UtilsView.dialogButton(
                  backgroundColor: Colors.red,
                  verticalPadding: MediaQuery.of(context).size.height * 0.02,
                  horizontalPadding: MediaQuery.of(context).size.width * 0.02,
                ),
                child: UtilsView.textWidget(
                    text: 'Leave',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1FCCF6),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }
}
