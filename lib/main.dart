import 'package:flutter/material.dart';
import 'package:poysha_planner/widgets/expenses.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          primary: const Color.fromARGB(255, 255, 228, 237),
        ),

        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 255, 228, 237),
          foregroundColor: Colors.black,
        ),
      ),
      home: const Expenses(),
    ),
  );
}
