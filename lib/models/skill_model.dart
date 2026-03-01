import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final IconData icon;
  final Color color;
  final String category;
  final String? imagePath; // optional asset path for technology image

  const SkillModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.category,
    this.imagePath,
  });
}
