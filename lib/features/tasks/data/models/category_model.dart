import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

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
      'quran': FlutterIslamicIcons.quran2,
      'mosque': FlutterIslamicIcons.mosque,
      'prayer': FlutterIslamicIcons.prayer,
      'school': Icons.school_outlined,
      'science': Icons.science_outlined,
      'shopping': Icons.shopping_cart_outlined,
      'favorite': Icons.favorite_border,
      'sports': Icons.sports_soccer,
      'music': Icons.music_note_outlined,
      'movie': Icons.movie_outlined,
      'palette': Icons.palette_outlined,
      'business': Icons.business_center_outlined,
      'money': Icons.attach_money,
      'food': Icons.restaurant_outlined,
      'coffee': Icons.coffee_outlined,
      'pets': Icons.pets,
      'car': Icons.directions_car_outlined,
      'other': Icons.category_outlined,
    };

    return iconsMap[iconName] ?? Icons.folder_outlined;
  }

  Color get color => Color(colorValue);
}
