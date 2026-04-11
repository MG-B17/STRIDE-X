import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AchievementEntity extends Equatable {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isUnlocked;

  const AchievementEntity({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isUnlocked,
  });

  @override
  List<Object?> get props => [title, isUnlocked];
}
