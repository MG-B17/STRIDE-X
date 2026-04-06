class TodayDataEntity {
  final int stepsCount;
  final double calories;
  final double distance;
  final int activeTimeSeconds;
  final DateTime date;

  TodayDataEntity({
    required this.stepsCount,
    required this.calories,
    required this.distance,
    required this.activeTimeSeconds,
    required this.date,
  });


  factory TodayDataEntity.fromMap(Map<String, dynamic> map) {
    return TodayDataEntity(
      stepsCount: map['steps_count'] ?? 0,
      calories: (map['calories'] ?? 0.0).toDouble(),
      distance: (map['distance'] ?? 0.0).toDouble(),
      activeTimeSeconds: map['active_time_seconds'] ?? 0,
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'steps_count': stepsCount,
      'calories': calories,
      'distance': distance,
      'active_time_seconds': activeTimeSeconds,
      'date': date.toIso8601String(),
    };
  }
}