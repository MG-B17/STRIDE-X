import 'package:flutter/widgets.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback onPaused;
  final VoidCallback onResumed;

  AppLifecycleHandler({
    required this.onPaused,
    required this.onResumed,
  }) {
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
      onPaused();
    } else if (state == AppLifecycleState.resumed) {
      onResumed();
    }
  }
}
