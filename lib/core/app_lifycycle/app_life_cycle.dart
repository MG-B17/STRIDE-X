import 'package:flutter/material.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
 
  int Function() getSteps;

  AppLifecycleHandler({
    required this.getSteps,
  });

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _save();
    }
  }

  Future<void> _save() async {
 //   final steps = getSteps();

  }
}