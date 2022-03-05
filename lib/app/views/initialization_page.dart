import 'dart:async';

import 'package:app_architecture/users/views/users_list.dart';
import 'package:flutter/material.dart';

class AppInitialization extends StatefulWidget {
  const AppInitialization({Key? key}) : super(key: key);

  @override
  State<AppInitialization> createState() => _AppInitializationState();
}

class _AppInitializationState extends State<AppInitialization> {
  @override
  void initState() {
    checkState();
    super.initState();
  }

  checkState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushAndRemoveUntil(UsersList.route(), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
