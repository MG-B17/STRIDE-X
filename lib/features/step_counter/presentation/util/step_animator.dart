class StepAnimator {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  /// Snap to a new starting step instantly.
  /// Important for Midnight Resets or Sensor Reboots handling.
  void reset(int newStep) {
    _currentStep = newStep;
  }

  /// Calculate the next UI step
  int animateTo(int targetStep) {
    final delta = targetStep - _currentStep;

    if (delta <= 0) return _currentStep;

    int increment;
    if (delta > 1000) {
      increment = delta ~/ 20; // Reaches target in ~20 frames (~0.3s) for huge deltas
    } else if (delta > 100) {
      increment = 10;
    } else if (delta > 50) {
      increment = 5;
    } else if (delta > 20) {
      increment = 3;
    } else {
      increment = 1;
    }

    _currentStep += increment;
    if (_currentStep > targetStep) _currentStep = targetStep;

    return _currentStep;
  }

}