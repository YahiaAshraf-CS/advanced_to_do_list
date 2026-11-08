import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String iconName;
  final int colorValue;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'colorValue': colorValue,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      iconName: map['iconName'] ?? 'folder',
      colorValue: map['colorValue'] ?? Colors.blue.value,
    );
  }

  IconData get iconData {
    final Map<String, IconData> iconsMap = {
      'folder': Icons.folder_outlined,
      'star': Icons.star_outline,
      'work': Icons.work_outline,
      'home': Icons.home_outlined,
      'fitness': Icons.fitness_center,
      'code': Icons.code,
      'book': Icons.book_outlined,
      'flight': Icons.flight,
    };

    return iconsMap[iconName] ?? Icons.folder_outlined;
  }

  Color get color => Color(colorValue);
}
