import 'package:flutter/material.dart';
import 'package:poysha_planner/model/expense.dart';
import 'package:poysha_planner/widgets/chart/chart.dart';
import 'package:poysha_planner/widgets/expenses_list/expense_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poysha_planner/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ">>${expense.name}<< was removed.",
          style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 255, 228, 237),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(83, 0, 0, 0),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,

      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Center(
      child: Text(
        "Time to spend some money!",
        style: GoogleFonts.montserrat(
          color: Colors.pink,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
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
        child:
            width < 600
                ? Column(
                  children: [
                    Text(
                      'Expenses',
                      style: GoogleFonts.montserratSubrayada(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                    Chart(expenses: _registeredExpenses),
                    Expanded(child: mainContent),
                  ],
                )
                : Column(
                  children: [
                    Text(
                      'Expenses',
                      style: GoogleFonts.montserratSubrayada(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Chart(expenses: _registeredExpenses)),
                        Expanded(child: mainContent),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}
