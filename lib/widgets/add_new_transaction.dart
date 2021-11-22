import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class AddNewTransaction extends StatefulWidget {
  final Function totalTransactionList;

  AddNewTransaction(this.totalTransactionList);

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }

    widget.totalTransactionList(
        enteredTitle, double.parse(enteredAmount), pickedDate);
    Navigator.of(context).pop();
  }

  DateTime pickedDate = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          pickedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter title'),
                controller: titleController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      'You picked ${DateFormat.yMMMd().format(pickedDate).toString()}'),
                  FlatButton(
                    onPressed: _showDatePicker, // show date pickker
                    child: Text(
                      "Pick a date",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColorDark,
                  )
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => addTransaction(),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                ),
                child: Text("Add transaction"),
              )
            ],
          )),
    );
  }
}
