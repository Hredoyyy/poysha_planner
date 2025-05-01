import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poysha_planner/model/expense.dart';
import 'package:poysha_planner/widgets/expenses_list/expense_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poysha_planner/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      name: "bike fuel",
      amount: 600,
      date: DateTime.now(),
      category: Categories.transportation,
    ),
    Expense(
      name: "socks",
      amount: 700,
      date: DateTime.now(),
      category: Categories.utilities,
    ),
  ];

  _openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poysha Planner',
          style: GoogleFonts.montserrat(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add, color: Colors.pink),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 165, 195),
              const Color.fromARGB(255, 145, 206, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ), // Set the backdrop color here
        child: Column(
          children: [
            Text(
              'Expenses',
              style: GoogleFonts.montserratSubrayada(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
            Expanded(child: ExpenseList(expenses: _registeredExpenses)),
          ],
        ),
      ),
    );
  }
}
