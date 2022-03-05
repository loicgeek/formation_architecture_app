import 'dart:async';
import 'dart:developer';

import 'package:app_architecture/app/config.dart';
import 'package:flutter/material.dart';

Future bootstrap(Widget builder) async {
  await Config.init();
  runApp(builder);
}
