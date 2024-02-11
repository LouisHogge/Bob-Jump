import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bob_jump/controller/routes.dart';

/// The main entry point of the application.
/// This sets up the app to run using the [MyApp] widget.
void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/homeMenu',
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
