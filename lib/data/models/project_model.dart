import 'package:flutter/material.dart';

class ProjectModel {
  const ProjectModel({
    required this.title,
    required this.description,
    required this.stack,
    required this.metric,
    required this.color,
  });

  final String title;
  final String description;
  final List<String> stack;
  final String metric;
  final Color color;
}
