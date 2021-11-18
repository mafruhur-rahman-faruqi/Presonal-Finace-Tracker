import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';

class ShowTransactionList extends StatelessWidget {
  final List<Transactions> transactionList;
  ShowTransactionList(this.transactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Flexible(
                    flex: 0,
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Text(
                        transactionList[index].amount.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          flex: 20,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              transactionList[index].title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Flexible(
                          flex: 20,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(DateFormat.yMMMd()
                                .format(transactionList[index].date)),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: transactionList.length,
    ));
  }
}
