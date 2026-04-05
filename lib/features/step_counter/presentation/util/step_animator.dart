class StepAnimator {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  /// Calculate the next UI step
  int animateTo(int targetStep) {
    final delta = targetStep - _currentStep;

    if (delta <= 0) return _currentStep;

    int increment;
    if (delta > 50) {
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