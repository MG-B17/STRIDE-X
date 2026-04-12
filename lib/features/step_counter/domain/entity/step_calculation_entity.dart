class StepsCalculationEntity {
  final int baseline;
  double stepCorrectionFactor;

  StepsCalculationEntity({
    required this.baseline,
    required this.stepCorrectionFactor,
  });

  StepsCalculationEntity copyWith({
    int? baseline,
    double? stepCorrectionFactor,
  }) {
    return StepsCalculationEntity(
      baseline: baseline ?? this.baseline,
      stepCorrectionFactor: stepCorrectionFactor ?? this.stepCorrectionFactor,
    );
  }
}



