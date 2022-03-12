import 'package:app_architecture/app/views/initialization_page.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppInitialization(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
    );
  }
}
