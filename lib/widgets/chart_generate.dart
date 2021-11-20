import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'chart_bar_ew.dart';

class ChartGenerate extends StatelessWidget {
  final List<Transactions> recentTransactions;

  ChartGenerate(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
          print(totalSum);
        }
      }

      return {
        "Day": DateFormat.E().format(weekday).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.amber[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
                label: data['Day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending);
          }).toList(),
        ));
  }
}

// <Widget>[
//                   Text(data['Day']),
//                   Text(data['amount'].toString()),
//                   Text(totalSpending == 0.0
//                       ? 0.0.toString()
//                       : ((data['amount'] as double) / totalSpending).toString())
//                   // we basically output it in a chartbar
//                 ],