abstract class CalibrationRepository {
  Future<void> saveFactor({required double factor});
  Future<double> getFactor();
}