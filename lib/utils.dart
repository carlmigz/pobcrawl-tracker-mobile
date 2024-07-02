import 'package:flutter/material.dart';

final window = WidgetsBinding.instance.platformDispatcher.views.first;
final Size deviceSize = window.physicalSize / window.devicePixelRatio;