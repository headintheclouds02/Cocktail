import 'package:flutter/material.dart';

class FavoriteColor {
  final int id;
  final String name;
  final String hexCode;

  FavoriteColor({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  factory FavoriteColor.fromJson(Map<String, dynamic> json) {
    return FavoriteColor(
      id: json['id'],
      name: json['name'],
      hexCode: json['hexCode'],
    );
  }

  Color toColor() {
    final hex = hexCode.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
