import 'package:flutter/material.dart';
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

    widget.totalTransactionList(enteredTitle, double.parse(enteredAmount));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ),
        ElevatedButton(
          onPressed: () => addTransaction(),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
          ),
          child: Text("Add transaction"),
        )
      ],
    ));
  }
}
