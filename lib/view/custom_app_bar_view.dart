import 'package:flutter/material.dart';

/// [CustomAppBar], stateless widget, creates a custom-styled app bar.
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFBA93C0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Center(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.yellow, Colors.orange],
            ).createShader(bounds);
          },
          child: Text(
            'Bob Jump',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.06,
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
        ),
      ),
    );
  }
}
