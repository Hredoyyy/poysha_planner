import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poysha_planner/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
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

  // var _enteredName = '';

  // void _saveName(String inputName) {
  //   _enteredName = inputName;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
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
                  ;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "cancel",
                  style: TextStyle(color: Color.fromARGB(255, 145, 206, 255)),
                ),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  print(_nameController.text);
                  print(_amountController.text);
                },
                child: Text("save", style: TextStyle(color: Colors.pink[400])),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
