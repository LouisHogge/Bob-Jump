import 'package:flutter/material.dart';
import 'package:bob_jump/view/utils_view.dart';

/// A utility class for creating and displaying custom dialogs.
///
/// [CustomDialog] provides [showDialog] to display a dialog with customizable
/// content. It utilizes [UtilsView] for consistent style.
class CustomDialog {
  void showDialogRequired({
    required BuildContext context,
    required String title,
    required Widget content,
    required Color backgroundColor,
    required double width,
    required double height,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: UtilsView.dialogBorderRadius(),
            backgroundColor: backgroundColor,
            child: SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: UtilsView.dialogEdge(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UtilsView.dialogTitle(title, context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Expanded(child: content),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: UtilsView.dialogButton(
                          backgroundColor: Colors.white,
                          verticalPadding:
                              MediaQuery.of(context).size.height * 0.03,
                          horizontalPadding:
                              MediaQuery.of(context).size.width * 0.07,
                        ),
                        child: UtilsView.textWidget(
                            text: 'Close',
                            color: Colors.lightGreen,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
