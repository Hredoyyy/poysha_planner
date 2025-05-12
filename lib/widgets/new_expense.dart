import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poysha_planner/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final Function onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Categories _selectedCategory = Categories.utilities;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.cyan[200]!, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.cyan[400]!, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.cyan[200], // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_nameController.text.trim().isEmpty ||
        enteredAmount == null ||
        invalidAmount ||
        _selectedDate == null) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please enter a valid name, amount, and date.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        name: _nameController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.of(context).pop();
  }
  // var _enteredName = '';

  // void _saveName(String inputName) {
  //   _enteredName = inputName;
  // }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, keyboard + 20),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink[200]!),
                            ),
                          ),
                          cursorColor: Colors.pink[100],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixText: '৳ ',
                            prefixStyle: TextStyle(color: Colors.pink[100]),
                            labelText: 'Amount',
                            labelStyle: TextStyle(color: Colors.pink[400]),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink[200]!),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.pink[100],
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _nameController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.pink[400]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink[200]!),
                      ),
                    ),
                    cursorColor: Colors.pink[100],
                  ),
                if (width > 600)
                  Row(
                    children: [
                      DropdownButton(
                        style: TextStyle(color: Colors.pink[400]),
                        dropdownColor: Colors.pink[50],
                        value: _selectedCategory,
                        items:
                            Categories.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Selecte Date'
                                  : formatter.format(_selectedDate!),
                              style: TextStyle(color: Colors.pink[400]),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month_outlined),
                              color: Colors.pink[200],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixText: '৳ ',
                            prefixStyle: TextStyle(color: Colors.pink[100]),
                            labelText: 'Amount',
                            labelStyle: TextStyle(color: Colors.pink[400]),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink[200]!),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.pink[100],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Selecte Date'
                                  : formatter.format(_selectedDate!),
                              style: TextStyle(color: Colors.pink[400]),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month_outlined),
                              color: Colors.pink[200],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (width > 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "cancel",
                          style: TextStyle(
                            color: Color.fromARGB(255, 145, 206, 255),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: _saveExpenseData,
                        child: Text(
                          "save",
                          style: TextStyle(color: Colors.pink[400]),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        style: TextStyle(color: Colors.pink[400]),
                        dropdownColor: Colors.pink[50],
                        value: _selectedCategory,
                        items:
                            Categories.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "cancel",
                          style: TextStyle(
                            color: Color.fromARGB(255, 145, 206, 255),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: _saveExpenseData,
                        child: Text(
                          "save",
                          style: TextStyle(color: Colors.pink[400]),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
