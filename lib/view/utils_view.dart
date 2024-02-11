import 'package:flutter/material.dart';

/// The [UtilsView] class provides a collection of static utility methods
/// for creating and styling various UI components like buttons, text widgets,
/// dialog elements, etc., to be used across the Flutter application.
class UtilsView {
  /// Creates a styled button with customizable color and rounded corners.
  /// This style is typically used for menu buttons in the application.
  ///
  /// [color]: The background color of the button.
  /// [radius]: The radius for the rounded corners of the button, defaulting to 15.0.
  static ButtonStyle menuButton({required Color color, double radius = 15.0}) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  /// Generates a button style for dialogs, with customizable background color,
  /// padding, and border radius.
  ///
  /// [backgroundColor]: The background color of the button.
  /// [verticalPadding]: Vertical padding inside the button.
  /// [horizontalPadding]: Horizontal padding inside the button.
  /// [borderRadius]: The radius for the rounded corners of the button, defaulting to 15.0.
  static ButtonStyle dialogButton(
      {required Color backgroundColor,
      required double verticalPadding,
      required double horizontalPadding,
      double borderRadius = 15.0}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
    );
  }

  /// Creates a text widget with custom color, font size, and font weight.
  ///
  /// [text]: The text to be displayed.
  /// [color]: The color of the text.
  /// [fontSize]: The font size of the text.
  /// [fontWeight]: The font weight of the text.
  static Text textWidget(
      {required String text,
      required Color color,
      required double fontSize,
      required FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  /// Provides symmetric edge insets for dialogs, scaled based on the
  /// current media query size of the context.
  ///
  /// [context]: The BuildContext to get media query size.
  static EdgeInsets dialogEdge(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * 0.03,
      horizontal: MediaQuery.of(context).size.width * 0.07,
    );
  }

  /// Creates a rounded rectangle border with a specified radius,
  /// commonly used for dialog elements.
  ///
  /// [radius]: The radius for the rounded corners, defaulting to 15.0.
  static RoundedRectangleBorder dialogBorderRadius({double radius = 15.0}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  /// Generates a shader-masked title widget for dialogs, with a gradient effect.
  ///
  /// [title]: The text of the title.
  /// [context]: The BuildContext to scale the font size based on the screen size.
  static ShaderMask dialogTitle(String title, BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.yellow, Colors.orange],
        ).createShader(bounds);
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.05,
          fontWeight: FontWeight.bold,
          shadows: const [
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }

  /// Constructs a widget displaying developer information, formatted with
  /// name and details, and styled text.
  ///
  /// [context]: The BuildContext to scale the font size based on the screen size.
  /// [name]: The name of the developer.
  /// [details]: Additional details about the developer.
  static Widget buildDeveloperInfo(
      BuildContext context, String name, String details) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.red,
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Text(
          details,
          style: TextStyle(
            color: Colors.red,
            fontSize: MediaQuery.of(context).size.height * 0.02,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}
