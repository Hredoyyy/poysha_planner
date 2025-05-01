import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Categories { food, transportation, entertainment, utilities, other }

const catIcons = {
  Categories.food: Icons.fastfood,
  Categories.transportation: Icons.motorcycle_sharp,
  Categories.entertainment: Icons.movie,
  Categories.utilities: Icons.add_chart,
  Categories.other: Icons.category,
};

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}
